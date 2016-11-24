package com.smt.webapp.weih5.utils;

import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import net.coobird.thumbnailator.Thumbnails;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.smt.webapp.util.imageUploader.MyUtils;
import com.sun.mail.util.BASE64DecoderStream;

import sun.misc.BASE64Decoder;

public class H5FileHelper {

	public static int rotateHeadImg(int userId, String orientation) {
		String path = getUploadPathForHeadImg();
		String indexPath = StringUtils.replace(path, "headImage", "indexHeadImage");
		String imageFileName = userId + ".png";

		String imageFilePath = path + imageFileName;
		String indexImageFilePath = indexPath + imageFileName;

		double angdeg = 90.0;
		if ("right".equals(orientation)) {
			angdeg = 90.0;
		} else if ("left".equals(orientation)) {
			angdeg = 270.0;
		}

		int indexResult = rotateImage(indexImageFilePath, angdeg);
		if (indexResult < 0) {
			return indexResult;
		}
		int result = rotateImage(imageFilePath, angdeg);
		if (result < 0) {
			return result;
		}
		return 0;
	}

	private static int rotateImage(String filePath, double angdeg) {
		FileOutputStream out = null;
		try {
			BufferedImage old_img = (BufferedImage) ImageIO.read(new File(filePath));
			
			int w = old_img.getWidth();
			int h = old_img.getHeight();
			//BufferedImage new_img = new BufferedImage(h, w, BufferedImage.TYPE_INT_BGR);
			
			BufferedImage new_img = Thumbnails.of(new File(filePath)).size(h, w).rotate(angdeg).asBufferedImage();
			
//			Graphics2D g2d = new_img.createGraphics();
//
//			AffineTransform origXform = g2d.getTransform();
//			AffineTransform newXform = (AffineTransform) (origXform.clone());
//			// center of rotation is center of the panel
//			double xRot = w / 2.0;
//			newXform.rotate(Math.toRadians(angdeg), xRot, xRot);
//
//			g2d.setTransform(newXform);
//			// draw image centered in panel
//			g2d.drawImage(old_img, 0, 0, null);
//			// Reset to Original
//			g2d.setTransform(origXform);
//			// 写到新的文件
			out = new FileOutputStream(filePath);
			ImageIO.write(new_img, "PNG", out);
			
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	private static String getUploadPathForHeadImg() {
		String uploadPath = ServletActionContext.getServletContext().getRealPath("/");
		String path = uploadPath.substring(0, uploadPath.lastIndexOf(System.getProperty("file.separator")));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")));
		path = path + "\\stageUpload\\headImage\\";
		// 设置目标文件
		path = path.replace("\\", System.getProperty("file.separator"));
		File file = new File(path);
		if (!file.exists()) {
			file.mkdirs();
		}
		return path;
	}

	private static String getUploadPathForArtImage(int userId, int albumId) {
		String uploadPath = ServletActionContext.getServletContext().getRealPath("/");
		String path = uploadPath.substring(0, uploadPath.lastIndexOf(System.getProperty("file.separator")));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")));
		path = path + "\\stageUpload\\img\\" + userId + "\\" + albumId + "\\";
		// 设置目标文件
		path = path.replace("\\", System.getProperty("file.separator"));
		File file = new File(path);
		if (!file.exists()) {
			file.mkdirs();
		}
		return path;
	}

	private static String getUploadPathForBiz() {
		// 设置上传文件目录
		String uploadPath = ServletActionContext.getServletContext().getRealPath("/");
		String path = uploadPath.substring(0, uploadPath.lastIndexOf(System.getProperty("file.separator")));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")));
		path = path + "\\stageUpload\\idCard\\";
		// 设置目标文件
		path = path.replace("\\", System.getProperty("file.separator"));
		File file = new File(path);
		if (!file.exists()) {
			file.mkdirs();
		}
		return path;
	}

	public static void persistHeadImg(String base64Code, int userId, String imageName) {
		String path = getUploadPathForHeadImg();
		String indexPath = StringUtils.replace(path, "headImage", "indexHeadImage");
		String saveName = userId + ".png";
		String newFilePath = path + saveName;

		FileOutputStream out = null;
		ByteArrayInputStream is = null;
		try {
			byte[] in = new BASE64Decoder().decodeBuffer(base64Code);
			is = new ByteArrayInputStream(in);
			BufferedImage old_img = (BufferedImage) ImageIO.read(is);
			int w = old_img.getWidth();
			int h = old_img.getHeight();
			BufferedImage new_img = new BufferedImage(h, w, BufferedImage.TYPE_INT_BGR);
			Graphics2D g2d = new_img.createGraphics();

			AffineTransform origXform = g2d.getTransform();
			AffineTransform newXform = (AffineTransform) (origXform.clone());
			// center of rotation is center of the panel
			double xRot = w / 2.0;
			newXform.rotate(Math.toRadians(270.0), xRot, xRot); // 旋转270度

			g2d.setTransform(newXform);
			// draw image centered in panel
			g2d.drawImage(old_img, 0, 0, null);
			// Reset to Original
			g2d.setTransform(origXform);
			// 写到新的文件
			out = new FileOutputStream(indexPath + saveName);
			ImageIO.write(new_img, "PNG", out);

			Thumbnails.of(new_img).size(110, 110).toFile(newFilePath);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public static String persistArtImage(String base64Code, int userId, int albumId, String imageName) {

		String path = getUploadPathForArtImage(userId, albumId);
		String saveName = MyUtils.randomRename(imageName, path);

		FileOutputStream out = null;
		ByteArrayInputStream is = null;
		try {
			byte[] in = new BASE64Decoder().decodeBuffer(base64Code);
			is = new ByteArrayInputStream(in);
			BufferedImage old_img = (BufferedImage) ImageIO.read(is);
			int w = old_img.getWidth();
			int h = old_img.getHeight();
			BufferedImage new_img = new BufferedImage(h, w, BufferedImage.TYPE_INT_BGR);
			Graphics2D g2d = new_img.createGraphics();

			AffineTransform origXform = g2d.getTransform();
			AffineTransform newXform = (AffineTransform) (origXform.clone());
			// center of rotation is center of the panel
			double xRot = w / 2.0;
			newXform.rotate(Math.toRadians(270.0), xRot, xRot); // 旋转270度

			g2d.setTransform(newXform);
			// draw image centered in panel
			g2d.drawImage(old_img, 0, 0, null);
			// Reset to Original
			g2d.setTransform(origXform);
			// 写到新的文件
			out = new FileOutputStream(path + saveName);
			ImageIO.write(new_img, "PNG", out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		String url = "\\stageUpload\\img\\" + userId + "\\" + albumId + "\\" + saveName;
		return url.replace("\\", "/");
	}

	public static String persistIdCardFile(String base64Code, String fileName, int userId) {

		String path = getUploadPathForBiz();
		String saveName = userId + fileName.substring(fileName.lastIndexOf("."));

		FileOutputStream out = null;
		ByteArrayInputStream is = null;
		try {
			byte[] in = new BASE64Decoder().decodeBuffer(base64Code);
			is = new ByteArrayInputStream(in);
			BufferedImage old_img = (BufferedImage) ImageIO.read(is);
			int w = old_img.getWidth();
			int h = old_img.getHeight();

			BufferedImage new_img = new BufferedImage(h, w, BufferedImage.TYPE_INT_BGR);
			Graphics2D g2d = new_img.createGraphics();

			AffineTransform origXform = g2d.getTransform();
			AffineTransform newXform = (AffineTransform) (origXform.clone());
			// center of rotation is center of the panel
			double xRot = w / 2.0;
			newXform.rotate(Math.toRadians(270.0), xRot, xRot); // 旋转270度

			g2d.setTransform(newXform);
			// draw image centered in panel
			g2d.drawImage(old_img, 0, 0, null);
			// Reset to Original
			g2d.setTransform(origXform);
			// 写到新的文件
			out = new FileOutputStream(path + saveName);
			ImageIO.write(new_img, "PNG", out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return saveName;
	}

	public static String persistOrgCardFile(String base64Code, String fileName, int userId) {

		// 设置上传文件目录
		String path = getUploadPathForBiz();
		String saveName = userId + "_3" + fileName.substring(fileName.lastIndexOf("."));
		String tempName = saveName + "_tmp";
		File toFile = new File(path, tempName);

		FileOutputStream out = null;
		ByteArrayInputStream is = null;

		try {
			byte[] in = new BASE64Decoder().decodeBuffer(base64Code);
			is = new ByteArrayInputStream(in);
			BufferedImage old_img = (BufferedImage) ImageIO.read(is);
			int w = old_img.getWidth();
			int h = old_img.getHeight();
			BufferedImage new_img = new BufferedImage(h, w, BufferedImage.TYPE_INT_BGR);
			Graphics2D g2d = new_img.createGraphics();

			AffineTransform origXform = g2d.getTransform();
			AffineTransform newXform = (AffineTransform) (origXform.clone());
			// center of rotation is center of the panel
			double xRot = w / 2.0;
			newXform.rotate(Math.toRadians(270.0), xRot, xRot); // 旋转270度

			g2d.setTransform(newXform);
			// draw image centered in panel
			g2d.drawImage(old_img, 0, 0, null);
			// Reset to Original
			g2d.setTransform(origXform);
			// 写到新的文件
			out = new FileOutputStream(path + saveName);
			ImageIO.write(new_img, "PNG", out);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return saveName;
	}
}
