from flask import Flask, request, jsonify, render_template
import easyocr
import requests
import json
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
reader = easyocr.Reader(['en', 'ko'])  # Assuming text is in English
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload_image', methods=['POST'])
def upload_image():
    if request.method == 'POST':
        # 전송 받은 파일이 이미지 파일 형태가 아니면 400리턴
        if 'image' not in request.files:
            return jsonify({'error': 'no file upload'}), 400
        image = request.files['image'].read()
        # Save the image and process it

        results = reader.readtext(image)

        # Convert results to your desired JSON structure
        data = convert_to_json(results)

        return jsonify(data)

def convert_to_json(ocr_results):
    # Initialize an empty list to hold the transformed data
    json_data = []

    # Loop through each result in the OCR results
    for (bbox, text, prob) in ocr_results:
        # 좌표 값과 확률을 기본 데이터 타입으로 변환
        bounding_box = [[float(x), float(y)] for (x, y) in bbox]
        prob = float(prob)

        result_dict = {
            "bounding_box": bounding_box,
            "text": text,
            "probability": prob
        }

        # Append the dictionary to our list
        json_data.append(result_dict)
        print(json_data)
    return json_data

url = "https://openapi.naver.com/v1/search/shop"
client_id = "lfSg8_GIvPjg_23n4SRf"
secret = "HxNwvFne4C"

@app.route('/search', methods=['POST'])
def search():
    if request.method == 'POST':
        data = json.loads(request.get_data())
        print(data)
        # 헤더 설정
        headers = {
            'X-Naver-Client-Id': client_id,
            'X-Naver-Client-Secret': secret,
            'Content-Type': 'application/json'
        }
        # GET 요청
        response = requests.get(url, headers=headers, params={"query": data['q'], "display":5})

        # 결과 출력
        if response.status_code == 200:
            print(response.json())  # 성공 시 JSON 데이터 출력
        else:
            print("Error:", response.status_code)
        return response.json()

if __name__ == '__main__':
    app.run(debug=True , host="0.0.0.0")
