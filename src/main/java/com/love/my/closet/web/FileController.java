package com.love.my.closet.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FileController {
	private static String CURR_IMATE_PATH ="c:\\tools\\spring_dev\\img";
	
	@RequestMapping("/download")
	public void downlode(@RequestParam("imageFileName")String imageFileName
			,HttpServletResponse resp) throws IOException {
		OutputStream out = resp.getOutputStream();
		String downFile = CURR_IMATE_PATH +"\\" + imageFileName;
		File file = new File(downFile);
		//해당경로 파일이 없을경우
		if(!file.exists()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND,"file not found");
			
		}
		resp.setHeader("Cache-Control","no-cache");
		resp.setHeader("Control dispostion","arrachment fileName=" +imageFileName);
		try(FileInputStream in = new FileInputStream(file)){
			byte[] buffer = new byte[1024 * 8];
			while(true) {
				int count = in.read(buffer);
				
				if(count ==-1) {
					break;
				}
				out.write(buffer,0,count);
			}
		}catch(IOException ex) {
			
		}finally {
			
		}
	}
	@RequestMapping("/multiImgUpload")
	public void multiImgUpload(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
		String sFileInfo ="";
		String fileName = req.getHeader("file-name");
		String prifix = fileName.substring(fileName.lastIndexOf(".")+1);
		prifix = prifix.toLowerCase();
		String path = CURR_IMATE_PATH;
		File file = new File(path);
		//저장 폴더 없을 경우 생성
		if(!file.exists()) {
			file.mkdir();
		}
		//저장된 파일 이름
		String realName = UUID.randomUUID().toString() + "." +prifix;
		InputStream is = req.getInputStream();
		OutputStream os = new FileOutputStream(new File(path + "\\" +realName));
		int read =0;
		byte buffer[] = new byte[1024];
		while((read = is.read(buffer)) != -1) {
			os.write(buffer,0,read);
		}
		if(is!= null) {
			is.close();		
		}
		os.flush();
		os.close();
		sFileInfo += "&bNewList=true";
		sFileInfo += "&sFileName=" + fileName;
		sFileInfo += "&sFileURL=/my/download?imageFileName=" +realName;
		PrintWriter print = resp.getWriter();
		print.print(sFileInfo);
		print.flush();
		print.close();
		
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@GetMapping("/uploadExternalImage")
    @ResponseBody
    public String uploadExternalImage(@RequestParam String imageUrl) {
        try {
            // 외부 이미지 다운로드
            URL url = new URL(imageUrl);
            URLConnection connection = url.openConnection();
            BufferedInputStream in = new BufferedInputStream(connection.getInputStream());
            String fileName = UUID.randomUUID().toString() + ".jpg"; // 확장자가 jpg인 경우
            String path = CURR_IMATE_PATH;
            FileOutputStream out = new FileOutputStream(path + "\\" + fileName);
            // 파일 저장
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(buffer, 0, buffer.length)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            out.close();
            in.close();
            return "{\"success\": true, \"fileName\": \"" + fileName + "\", \"fileUrl\": \"/downloadImage?fileName=" + fileName + "\"}";
        } catch (IOException e) {
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"Upload failed\"}";
        }
    }
}
