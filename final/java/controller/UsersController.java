package com.hobbycam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hobbycam.lessonRecord.model.LessonRecordDAO;
import com.hobbycam.users.model.UsersDAO;
import com.hobbycam.users.model.UsersDTO;


import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.*;

@Controller
public class UsersController {
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	UsersDAO usersDao;

	@Autowired
	private LessonRecordDAO lrdao;
	
	@Autowired
	private JavaMailSender mailSender;


	 
/**join*/
	//change page emailCheck
	@RequestMapping(value="/userJoin.do", method = RequestMethod.GET)
	public ModelAndView openUserJoin() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("users/userJoinAuth");
		return mav;
	}
	
	//email Join email send
		@RequestMapping("/userSendJoinAuth.do")
		public ModelAndView sendJoinAuth(String email ,
				HttpSession session, HttpServletResponse resp,HttpServletRequest req) {
			
			StringBuffer url = req.getRequestURL();
			int findUrl=url.indexOf("hobbycampus");
			String lastUrl=url.substring(0,findUrl);
	
			
			
			ModelAndView mav=new ModelAndView();
			int count=usersDao.getEmailCount(email);
			
			String msg="";
			if(count>0) {
				msg="이미 가입하거나 탈퇴한 email입니다.";
				mav.addObject("result","false");
				
			} else if(count==0) {

				String code=(int)(Math.random()*10000)+"";
				String subject="hobbyCampus 입니다~ ^^";
				String content="인증을 진행해 주세요~  "
							
		                   +"<a href='"+lastUrl+"hobbycampus/userJoinAuthCheck.do?"
		                   + "email="+email+"&code="+code+"'target=_blank'>이메일 인증확인 클릭클릭</a>"
		                   + " ^^";
				
				msg=sendEmailAuth(email, subject, content, code, session, resp);
				
				if(msg.equals("")) {
					msg="이메일을 보낼 수 없습니다. 메일 주소를 다시 확인해 주세요";
					mav.addObject("result","false");
					
				} else {
					mav.addObject("result","true");
				}
				
			}
			mav.addObject("msg",msg);
			mav.setViewName("hobbyJson");
			return mav;
		}
			
			
						//send email auth inner 
						public String sendEmailAuth(String email,
								String subject, String content, String code,
								HttpSession session, HttpServletResponse resp) {
						
							String msg;
							
							try {
									emailSend(email, subject, content);
									
									msg="인증 메일을 확인해 주세요";
									
						    			Cookie ck=new Cookie("u_email", email);
						    			ck.setMaxAge(1200);
						    			resp.addCookie(ck);
						    			
						    			Cookie cook=new Cookie("code", code);
						    			cook.setMaxAge(600);
						    			resp.addCookie(cook);
				
						    			
								} catch (Exception e) {
									e.printStackTrace();
									msg="";
								}
							
							return msg;
						}
	
			
			
						// check email auth inner
						public int checkEmailAuth(String email, String code, HttpServletRequest req) {
							
							
					
							
							Cookie cks[]=req.getCookies();
							String emailvalue="";
							String codevalue="";
							
							 if(cks!=null) {
								 for(int i=0;i<cks.length;i++) {
									 if(cks[i].getName().equals("u_email")) {
										 
										 emailvalue=cks[i].getValue();
									 }
									 if(cks[i].getName().equals("code")) {
										 codevalue=cks[i].getValue();
									 }
								 }
							 }
							 
						
							
							
							int count=0;
							 if(email.equals(emailvalue) && code.equals(codevalue)) {
								count=1;
							 } 
							return count;
						}

						
					//email send module inner
						public int emailSend(String email, String subject, String content){
							
							MimeMessage message = mailSender.createMimeMessage();
							int count=0;
							try {  
								message.setSubject(subject);
					            message.setContent(content,"text/html;charset=utf-8");
					            message.setFrom(new InternetAddress("lemoni3710@gmail.com"));
					            message.addRecipient(Message.RecipientType.TO,
					                 new InternetAddress(email));
					            mailSender.send(message);
							
							} catch (Exception e) {
								e.printStackTrace();
							}
							return count;
						}
							
						
						//save Email get cookies inner
						public String saveEmail(HttpServletRequest req,
								HttpServletResponse resp) {
							
							Cookie cks[]=req.getCookies();
							String emailvalue="";
							
							 if(cks!=null) {
								 for(int i=0;i<cks.length;i++) {
									 if(cks[i].getName().equals("u_email")) {
										 emailvalue=cks[i].getValue();
										 
									Cookie cook=new Cookie("code", null);
									cook.setMaxAge(0);
									resp.addCookie(cook);

									 }
								 }
							 }
							 return emailvalue;
						}
	
		
	// after email Auth
		@RequestMapping("/userJoinAuthCheck.do" )
		public ModelAndView checkJoinAuth(String email, String code, HttpServletRequest req) {
			ModelAndView mav=new ModelAndView();
			int count=checkEmailAuth(email, code, req);
			
			if(count>0) {
				mav.setViewName("redirect:/userJoinForm.do");
			} else {
				mav.addObject("msg","잘못된 접근입니다.");
				mav.setViewName("users/userJoinMsg");
			}
			return mav;
		}
		

		@RequestMapping("/userJoinForm.do")
		public ModelAndView userJoinForm(HttpServletRequest req
					,HttpServletResponse resp){
			
			String emailvalue=saveEmail(req,resp);
			 
			ModelAndView mav=new ModelAndView();
			mav.addObject("u_email",emailvalue);
			mav.setViewName("users/userJoin");
			return mav;
		}
		

		
	
	// nameCheck
	@RequestMapping("/userNameCheck.do")
	public ModelAndView findUserName(String name) {
		
		int result=usersDao.getNameCount(name);
	
		ModelAndView mav=new ModelAndView();
		mav.addObject("result",result);
		mav.setViewName("hobbyJson");
		return mav;
	}
	
	@RequestMapping("/userTelCheck.do")
	public ModelAndView findUserTel(String tel) {
		
		int result=usersDao.getTel(tel);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("result",result);
		mav.setViewName("hobbyJson");
		return mav;
	}
		
	
	
	
	//email join
	@RequestMapping(value="/userJoin.do",method = RequestMethod.POST)
	public ModelAndView setUserJoin(UsersDTO dto, 
	@RequestParam("upload") MultipartFile upload /*, HttpServletRequest request, HttpServletResponse response_email*/) {

		//file Upload and dto.setU_img	
		if (upload.isEmpty()) {
				dto.setU_img("user.png");
		} else {
			String imgname=copyInto(dto.getU_email(), upload);
			dto.setU_img(imgname);
		}
			  
		//emailJoin
		
		int count=usersDao.setUser(dto);
		
		String msg=count>0?"가입 완료되었습니다. 로그인 해 주세요":"가입 실패했습니다. 메일인증부터 다시 진행해주세요";
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("msg",msg);
		mav.setViewName("users/userJoinMsg");
		
		return mav;
	}
	
					//profile file copy method
						public String copyInto(String email, MultipartFile upload) {
				
							String filename = upload.getOriginalFilename();
							String file4= filename.substring(filename.length()-4, filename.length());
							String imgname=email+file4;
							String path=servletContext.getRealPath("/hobbyImg/userImg/");
							
							try {
								byte bytes[]=upload.getBytes();
								File f=new File(path+imgname);
								FileOutputStream fos=new FileOutputStream(f);
								fos.write(bytes);
								fos.close();
								
							} catch (IOException e) {
								e.printStackTrace();
							}
							return imgname;
						}


	@RequestMapping("/userJoinPolicy.do")
	public ModelAndView joinPolicy() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("users/joinPolicy");
		return mav;
	}
						
						
						
						
						
						
/**Login*/
	@RequestMapping(value="/userLogin.do",method = RequestMethod.GET)
	public ModelAndView openUserLogin() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("users/userLogin");
		return mav;
	}
	    
	
		//login
	    @RequestMapping(value="/userLogin.do", method = RequestMethod.POST)
	    public ModelAndView userLogin(String u_email,String u_pwd, 
	    	HttpSession session, String savemail, HttpServletResponse resp) {
	    	ModelAndView mav=new ModelAndView();

	    	int count=usersDao.getLoginPwd(u_email, u_pwd);
	
	    	if(count==usersDao.DEL) {
	    		mav.addObject("msg","탈퇴한 이메일입니다.");
	    		
	    	} else if(count==usersDao.LOGIN_OK) {
	    		UsersDTO dto=usersDao.getUserName(u_email);
	    		String u_name=dto.getU_name();
	    		int u_idx=dto.getU_idx();
	    		
	    		Integer t_idx=usersDao.getUserTidx(u_idx);
	    	
	    		session.setAttribute("u_name", u_name);
	    		session.setAttribute("u_idx", dto.getU_idx());
	    		
	    		if(t_idx!=null) {
	    			session.setAttribute("t_idx", t_idx);
	
	    			
	    		}
	    		
	    		
	    		if(savemail==null) {
	    			Cookie ck=new Cookie("savemail", u_email);
	    			ck.setMaxAge(0);
	    			resp.addCookie(ck);
	    			
	    		} else {
	    			Cookie ck=new Cookie("savemail", u_email);
	    			ck.setMaxAge(60*60*24*30);
	    			resp.addCookie(ck);
	    		}
	    		
	    	
	    		
	    		mav.addObject("msg",u_name+"님 환영합니다.");
	    		mav.addObject("u_name",u_name);
	    		mav.setViewName("users/usersMsg3");
	    		return mav;
	    		
	    	} else if(count==usersDao.NOT_ID||count==usersDao.NOT_PWD) {
	    		mav.addObject("msg","이메일 혹은 비밀번호를 확인해 주세요");
	    		
	    	} else {
	    		mav.addObject("msg","로그인 할 수 없습니다. 고객센터에 전화주세요");
	    	}
	    	mav.setViewName("hobbyJson");
	    	return mav;
	    }
	    
	    
	@RequestMapping("/userLogout.do")
	public ModelAndView userLogout(HttpServletRequest req) {
		HttpSession session=req.getSession();

		
		session.invalidate();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg","로그아웃되었습니다.");
		mav.addObject("gopage","index.do");
		mav.setViewName("users/usersMsg");
		return mav;
	}


	
	//email 
	@RequestMapping(value="/userEmailFindForm.do", method = RequestMethod.GET)
	public ModelAndView getUserEmailForm() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("users/userEmailFind");
		return mav;
	}
	
	
	@RequestMapping("/userEmailFind.do")
	public ModelAndView getUserEmail(String u_tel, String u_gender) {
		
		UsersDTO dto= usersDao.getUserEmail(u_tel, u_gender);
		
		
		String msg="";
				if(dto==null) {
					msg="계정이 없거나 정보가 틀립니다.";
				} else if (dto.getU_state().equals("탈퇴")){
					msg="탈퇴한 이메일입니다.";
				} else {
					String email=dto.getU_email();
					int mail=email.indexOf("@");
					String u_email=email.substring(0,2)+"***"+email.substring(mail,email.length());
					msg="찾는 메일 주소는 "+u_email+"입니다.";
				}
				
	
		ModelAndView mav=new ModelAndView();
		mav.addObject("msg",msg);
		mav.setViewName("hobbyJson");
		return mav;
		
	}
	
	
	//pwd 
	@RequestMapping(value="/userPwdFind.do" , method = RequestMethod.GET)
	public ModelAndView openPwdFind() {
		ModelAndView mav=new ModelAndView() ;
		mav.setViewName("users/userPwdFind");
		return mav;
	}
    
	
	@RequestMapping("/userPwdSend.do")
	public ModelAndView sendPwdAuth(String email,HttpSession session, HttpServletRequest req,
				HttpServletResponse resp) {
			
			StringBuffer url = req.getRequestURL();
			int findUrl=url.indexOf("hobbycampus");
			String lastUrl=url.substring(0,findUrl);
	
			
			ModelAndView mav=new ModelAndView();
			int count=usersDao.getPwdCount(email);

			String msg="";
			if(count==usersDao.NOT_ID) {
				msg="가입하지 않은 아이디입니다.";
				mav.addObject("result","false");
				
				
			} else if(count==usersDao.DEL) {
				msg="탈퇴한 아이디입니다.";
				mav.addObject("result","false");
				
				
			} else if(count==3) {
					
					String code=(int)(Math.random()*10000)+"";
					String subject="hobbyCampus 비밀번호 변경입니다 ";
					String content="비밀번호 변경을 위해 인증을 진행해 주세요~  "
			                   +"<a href='"+lastUrl+"hobbycampus/userPwdAuth.do?"
			                   + "email="+email+"&code="+code+"'target=_blank'>비밀번호 변경 클릭클릭</a>"
			                   + "클릭클릭</a> ^^";
					
					msg=sendEmailAuth(email, subject, content, code, session, resp);
			
					
					if(msg.equals("")) {
						msg="이메일을 보낼 수 없습니다. 메일 주소를 다시 확인해 주세요";
						mav.addObject("result","false");
						
					} else {
						mav.addObject("result","true");
					}
					
			}
			 
			mav.addObject("msg",msg);
			mav.setViewName("hobbyJson");
			return mav;
			
		}
	
	
	
	//after email Check pwdSer
		@RequestMapping("/userPwdAuth.do" )
		public ModelAndView checkPwdAuth(String email, String code, HttpServletRequest req) {
			ModelAndView mav=new ModelAndView();
			int count =checkEmailAuth(email, code, req);
			
			if(count>0) {
				 mav.setViewName("redirect:/userPwdForm.do");

			 } else {
				 
				 mav.addObject("msg","잘못된 접근입니다.");
				 mav.setViewName("users/userJoinMsg");
			 }
			return mav;
	}
		

	
	@RequestMapping("/userPwdForm.do")
		public ModelAndView updateUserPwdForm(HttpServletRequest req,
				HttpServletResponse resp){
			
			String emailvalue=saveEmail(req,resp);
		
			ModelAndView mav=new ModelAndView();
			mav.addObject("u_email",emailvalue);
			mav.setViewName("users/userPwdUpdate");
			return mav;
		}
	

	@RequestMapping("/userPwdUpdate.do")
	public ModelAndView updateUserPwd(UsersDTO dto) {
		ModelAndView mav=new ModelAndView() ;
		
		int count=usersDao.updateUserPwd(dto);
		
		String msg= count>0?"비밀번호 변경 완료" :  "비밀번호 변경 실패"; 
		
		mav.addObject("msg",msg);
		mav.setViewName("users/usersMsg2");
		return mav;
	}
	
	
	@RequestMapping("/userUpdateForm.do")
	public ModelAndView updateUserForm(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView();
		
		HttpSession session=req.getSession();
		
		if(session.getAttribute("u_idx")==null) {
			mav.addObject("msg","로그인을 진행해 주세요");
			mav.addObject("gopage","index.do");
			mav.setViewName("users/usersMsg");
			return mav;
		}
		
		int idx=(int)session.getAttribute("u_idx");
		UsersDTO dto= usersDao.getUserInfo(idx);
		
		mav.addObject("dto",dto);
		mav.setViewName("users/userUpdate");
		
		return mav;
	}
	

	@RequestMapping(value="/userUpdate.do" ,method = RequestMethod.POST)
	public ModelAndView updateUserInfo(UsersDTO dto, @RequestParam("upload") MultipartFile upload, HttpServletRequest req) {
		ModelAndView mav=new ModelAndView();
		
		HttpSession session=req.getSession();
		int idx=(int)session.getAttribute("u_idx");
		dto.setU_idx(idx);
		
		String imgname="";

		if (!upload.isEmpty()) {
			imgname=copyInto(dto.getU_email(), upload);
		} else {
			imgname=dto.getU_img();
		}
		
		
		dto.setU_img(imgname);
		
		int count=usersDao.updateUserInfo(dto);
		String msg=count>0?"회원정보가 수정되었습니다.":"수정 불가합니다.";
		if(count>0) {
			session.setAttribute("u_name", dto.getU_name());
		}		
		
		mav.addObject("msg",msg);
		mav.setViewName("users/usersMsg2");
		
		return mav;
	}
	
	@RequestMapping("/userDelete.do")
	public ModelAndView deleteUserInfo(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView();
		
		HttpSession session=req.getSession();
		int idx=(int)session.getAttribute("u_idx");
		
		int count=usersDao.deleteUserInfo(idx);
		
		String msg=count>0?"탈퇴 완료되었습니다.":"탈퇴할 수 없습니다.";
		
		session.invalidate();
		String gopage="index.do";
		
		mav.addObject("msg",msg);
		mav.addObject("gopage",gopage);
		mav.setViewName("users/usersMsg");
		
		return mav;
	}
	
}