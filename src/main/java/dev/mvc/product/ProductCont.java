package dev.mvc.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.book.BookProcInter;
import dev.mvc.book.BookVO;
import dev.mvc.bookgrp.BookgrpProcInter;
import dev.mvc.bookgrp.BookgrpVO;
//import dev.mvc.member.MemberProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ProductCont {
  @Autowired
  @Qualifier("dev.mvc.bookgrp.BookgrpProc")
  private BookgrpProcInter bookgrpProc;
  
  @Autowired
  @Qualifier("dev.mvc.book.BookProc")
  private BookProcInter bookProc;
  
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;
  
  public ProductCont() {
    System.out.println("-> ProductCont created.");
  }

  /**
   * 새로고침 방지
   * @return
   */
  @RequestMapping(value="/product/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  /**
   * 등록폼
   * 사전 준비된 레코드: 관리자 1번, bookno 1번, bookgrpno 1번을 사용하는 경우 테스트 URL
   * http://localhost:9091/product/create.do?bookno=1
   * 
   * @return
   */
  @RequestMapping(value = "/product/create.do", method = RequestMethod.GET)
  public ModelAndView create(int bookno) {
    ModelAndView mav = new ModelAndView();
    
    BookVO bookVO = this.bookProc.read(bookno);
    BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
    
    mav.addObject("bookVO", bookVO);
    mav.addObject("bookgrpVO", bookgrpVO);
    
    mav.setViewName("/product/create"); // /webapp/WEB-INF/views/product/create.jsp
    // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
    // mav.addObject("content", content);

    return mav; // forward
  }
  
  /**
   * 등록 처리 http://localhost:9090/product/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/product/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, ProductVO productVO) {
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String file1 = "";          // 원본 파일명 image
    String file1saved = "";  // 저장된 파일명, image
    String thumb1 = "";     // preview image

    // 기준 경로 확인
    String user_dir = System.getProperty("user.dir");
    System.out.println("--> User dir: " + user_dir);
    //  --> User dir: F:\ai8\ws_frame\resort_v1sbm3a
    
    // 파일 접근임으로 절대 경로 지정, static 지정
    // 완성된 경로 F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/product/storage
    String upDir =  user_dir + "/src/main/resources/static/product/storage/"; // 절대 경로
    
    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    // <input type='file' class="form-control" name='file1MF' id='file1MF' 
    //           value='' placeholder="파일 선택">
    MultipartFile mf = productVO.getFile1MF();
    
    file1 = mf.getOriginalFilename(); // 원본 파일명
    long size1 = mf.getSize();  // 파일 크기
    
    if (size1 > 0) { // 파일 크기 체크
      // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
      file1saved = Upload.saveFileSpring(mf, upDir); 
      
      if (Tool.isImage(file1saved)) { // 이미지인지 검사
        // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
        thumb1 = Tool.preview(upDir, file1saved, 200, 150); 
      }
      
    }    
    
    productVO.setFile1(file1);
    productVO.setFile1saved(file1saved);
    productVO.setThumb1(thumb1);
    productVO.setSize1(size1);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    // Call By Reference: 메모리 공유, Hashcode 전달
    int cnt = this.productProc.create(productVO); 
    
    // -------------------------------------------------------------------
    // PK의 return
    // -------------------------------------------------------------------
    // System.out.println("--> productno: " + productVO.getproductno());
    // mav.addObject("productno", productVO.getproductno()); // redirect parameter 적용
    // -------------------------------------------------------------------
    
//    if (cnt == 1) {
//      bookProc.increaseCnt(productVO.getbookno()); // 글수 증가
//    }
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    // System.out.println("--> bookno: " + productVO.getbookno());
    // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
    mav.addObject("bookno", productVO.getBookno()); // redirect parameter 적용
    mav.addObject("url", "/product/create_msg"); // create_msg.jsp, redirect parameter 적용
    
    // 연속 입력 지원용 변수, Call By Reference에 기반하여 productno를 전달 받음
    mav.addObject("productno", productVO.getProductno());

    mav.setViewName("redirect:/product/msg.do"); 
    
    return mav; // forward
  }
  
  /**
   * 카테고리별 목록 http://localhost:9090/product/list_by_bookno.do
   * 
   * @return
   */
   @RequestMapping(value = "/product/list_by_bookno.do", method = RequestMethod.GET)
    public ModelAndView list_by_bookno(int bookno) { 
      ModelAndView mav = new  ModelAndView(); // /webapp/product/list_by_bookno.jsp //
      mav.setViewName("/product/list_by_bookno");
      
      // 테이블 이미지 기반, list_by_bookno.jsp
      mav.setViewName("/product/list_by_bookno");
      
      BookVO bookVO = this.bookProc.read(bookno); mav.addObject("bookVO", bookVO);
      
      BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
      mav.addObject("bookgrpVO", bookgrpVO);
      
      List<ProductVO> list = this.productProc.list_by_bookno(bookno);
      mav.addObject("list", list);
      
      return mav; // forward 
    }
   
   /**
    * 목록 + 검색 지원
    * http://localhost:9091/product/list_by_bookno_search.do?bookno=1&word=스위스
    * @param bookno
    * @param word
    * @return
    */
     @RequestMapping(value = "/product/list_by_bookno_search.do", method = RequestMethod.GET)
     public ModelAndView list_by_bookno_search(@RequestParam(value="bookno", defaultValue="1") int bookno,
                                                                     @RequestParam(value="word", defaultValue="") String word ) {
     
     ModelAndView mav = new ModelAndView(); 
          
     // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용 
     HashMap<String, Object> map = new HashMap<String, Object>(); 
     map.put("bookno", bookno); // #{bookno}
     map.put("word", word); // #{word}
     
     // 검색 목록 
     List<ProductVO> list = productProc.list_by_bookno_search(map);
     mav.addObject("list", list);
     
     // 검색된 레코드 갯수 
     int search_count = productProc.search_count(map);
     mav.addObject("search_count", search_count);
     
     BookVO bookVO = bookProc.read(bookno); 
     mav.addObject("bookVO", bookVO);
     
     BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
     mav.addObject("bookgrpVO", bookgrpVO);
     
     mav.setViewName("/product/list_by_bookno_search");   // /product/list_by_bookno_search.jsp
     
     return mav; 
   }
     
     /**
      * 목록 + 검색 + 페이징 지원
      * http://localhost:9091/product/list_by_bookno_search_paging.do?bookno=1&word=스위스&now_page=1
      * 
      * @param bookno
      * @param word
      * @param now_page
      * @return
      */
     @RequestMapping(value = "/product/list_by_bookno_search_paging.do", method = RequestMethod.GET)
     public ModelAndView list_by_bookno_search_paging(@RequestParam(value = "bookno", defaultValue = "1") int bookno,
         @RequestParam(value = "word", defaultValue = "") String word,
         @RequestParam(value = "now_page", defaultValue = "1") int now_page,
         @RequestParam(value="cartno", defaultValue = "1") int cartno,
         HttpServletRequest request) {
       System.out.println("--> now_page: " + now_page);

       ModelAndView mav = new ModelAndView();

       // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
       HashMap<String, Object> map = new HashMap<String, Object>();
       map.put("bookno", bookno); // #{bookno}
       map.put("word", word); // #{word}
       map.put("now_page", now_page); // 페이지에 출력할 레코드의 범위를 산출하기위해 사용

       // 검색 목록
       List<ProductVO> list = productProc.list_by_bookno_search_paging(map);
       mav.addObject("list", list);

       // 검색된 레코드 갯수
       int search_count = productProc.search_count(map);
       mav.addObject("search_count", search_count);

       BookVO bookVO = bookProc.read(bookno);
       mav.addObject("bookVO", bookVO);

       BookgrpVO bookgrpVO = bookgrpProc.read(bookVO.getBookgrpno());
       mav.addObject("bookgrpVO", bookgrpVO);

       /*
        * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
        * 18 19 20 [다음]
        * @param list_file 목록 파일명
        * @param bookno 카테고리번호
        * @param search_count 검색(전체) 레코드수
        * @param now_page 현재 페이지
        * @param word 검색어
        * @return 페이징 생성 문자열
        */
       String paging = productProc.pagingBox("list_by_bookno_search_paging.do", bookno, search_count, now_page, word);
       mav.addObject("paging", paging);

       mav.addObject("now_page", now_page);
       
       
       // -------------------------------------------------------------------------------
       // 쇼핑 카트 장바구니에 상품 등록전 로그인 폼 출력 관련 쿠기  
       // -------------------------------------------------------------------------------
       Cookie[] cookies = request.getCookies();
       Cookie cookie = null;

       String ck_id = ""; // id 저장
       String ck_id_save = ""; // id 저장 여부를 체크
       String ck_passwd = ""; // passwd 저장
       String ck_passwd_save = ""; // passwd 저장 여부를 체크

       if (cookies != null) {  // Cookie 변수가 있다면
         for (int i=0; i < cookies.length; i++){
           cookie = cookies[i]; // 쿠키 객체 추출
           
           if (cookie.getName().equals("ck_id")){
             ck_id = cookie.getValue();                                 // Cookie에 저장된 id
           }else if(cookie.getName().equals("ck_id_save")){
             ck_id_save = cookie.getValue();                          // Cookie에 id를 저장 할 것인지의 여부, Y, N
           }else if (cookie.getName().equals("ck_passwd")){
             ck_passwd = cookie.getValue();                          // Cookie에 저장된 password
           }else if(cookie.getName().equals("ck_passwd_save")){
             ck_passwd_save = cookie.getValue();                  // Cookie에 password를 저장 할 것인지의 여부, Y, N
           }
         }
       }
       
       System.out.println("-> ck_id: " + ck_id);
       
       mav.addObject("ck_id", ck_id); 
       mav.addObject("ck_id_save", ck_id_save);
       mav.addObject("ck_passwd", ck_passwd);
       mav.addObject("ck_passwd_save", ck_passwd_save);
       // ------------------------------------------------------------------------------- 

       // /product/list_by_bookno_table_img1_search_paging.jsp
       mav.setViewName("/product/list_by_bookno_search_paging");

       return mav;
     }
     
     /**
      * Grid 형태의 화면 구성 http://localhost:9091/product/list_by_bookno_grid.do
      * 
      * @return
      */
     @RequestMapping(value = "/product/list_by_bookno_grid.do", method = RequestMethod.GET)
     public ModelAndView list_by_bookno_grid(int bookno) {
       ModelAndView mav = new ModelAndView();
       
       BookVO bookVO = this.bookProc.read(bookno);
       mav.addObject("bookVO", bookVO);
       
       BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
       mav.addObject("bookgrpVO", bookgrpVO);
       
       List<ProductVO> list = this.productProc.list_by_bookno(bookno);
       mav.addObject("list", list);

       // 테이블 이미지 기반, /webapp/product/list_by_bookno_grid.jsp
       mav.setViewName("/product/list_by_bookno_grid");

       return mav; // forward
     }
     
     /**
      * 상품 정보 수정 폼
      * 사전 준비된 레코드: 관리자 1번, bookno 1번, bookgrpno 1번을 사용하는 경우 테스트 URL
      * http://localhost:9091/product/create.do?bookno=1
      * 
      * @return
      */
     @RequestMapping(value = "/product/product_update.do", method = RequestMethod.GET)
     public ModelAndView product_update(int bookno, int productno) {
       ModelAndView mav = new ModelAndView();
       
       BookVO bookVO = this.bookProc.read(bookno);
       BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
       ProductVO productVO = this.productProc.read(productno);
       
       mav.addObject("bookVO", bookVO);
       mav.addObject("bookgrpVO", bookgrpVO);
       mav.addObject("productVO", productVO);
       
       mav.setViewName("/product/product_update"); // /views/product/product_update.jsp
       // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
       // mav.addObject("content", content);

       return mav; // forward
     }
     
     /**
      * 상품 정보 수정 처리 http://localhost:9091/product/product_update.do
      * 
      * @return
      */
     @RequestMapping(value = "/product/product_update.do", method = RequestMethod.POST)
     public ModelAndView product_update(ProductVO productVO) {
       ModelAndView mav = new ModelAndView();
       
       // Call By Reference: 메모리 공유, Hashcode 전달
       int cnt = this.productProc.product_update(productVO);
       
       mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
       mav.addObject("bookno", productVO.getBookno()); // redirect parameter 적용

       // 연속 입력 지원용 변수, Call By Reference에 기반하여 productno를 전달 받음
       mav.addObject("productno", productVO.getProductno());
       
       mav.addObject("url", "/product/product_update_msg"); // product_update_msg.jsp

       mav.setViewName("redirect:/product/msg.do"); 
       
       return mav; // forward
     }
     
  // http://localhost:9091/product/read.do
     /**
      * 조회
      * @return
      */
     @RequestMapping(value="/product/read.do", method=RequestMethod.GET )
     public ModelAndView read(HttpServletRequest request, int productno) {
       // public ModelAndView read(int productno, int now_page) {
       // System.out.println("-> now_page: " + now_page);
       
       ModelAndView mav = new ModelAndView();

       ProductVO productVO = this.productProc.read(productno);
       mav.addObject("productVO", productVO); // request.setAttribute("productVO", productVO);

       BookVO bookVO = this.bookProc.read(productVO.getBookno());
       mav.addObject("bookVO", bookVO); 

       BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
       mav.addObject("bookgrpVO", bookgrpVO); 
       
       mav.setViewName("/product/read"); // /WEB-INF/views/product/read.jsp
       
       /*
        * //
        * -----------------------------------------------------------------------------
        * -- // 쇼핑 카트 장바구니에 상품 등록전 로그인 폼 출력 관련 쿠기 //
        * -----------------------------------------------------------------------------
        * -- Cookie[] cookies = request.getCookies(); Cookie cookie = null;
        * 
        * String ck_id = ""; // id 저장 String ck_id_save = ""; // id 저장 여부를 체크 String
        * ck_passwd = ""; // passwd 저장 String ck_passwd_save = ""; // passwd 저장 여부를 체크
        * 
        * if (cookies != null) { // Cookie 변수가 있다면 for (int i=0; i < cookies.length;
        * i++){ cookie = cookies[i]; // 쿠키 객체 추출
        * 
        * if (cookie.getName().equals("ck_id")){ ck_id = cookie.getValue(); // Cookie에
        * 저장된 id }else if(cookie.getName().equals("ck_id_save")){ ck_id_save =
        * cookie.getValue(); // Cookie에 id를 저장 할 것인지의 여부, Y, N }else if
        * (cookie.getName().equals("ck_passwd")){ ck_passwd = cookie.getValue(); //
        * Cookie에 저장된 password }else if(cookie.getName().equals("ck_passwd_save")){
        * ck_passwd_save = cookie.getValue(); // Cookie에 password를 저장 할 것인지의 여부, Y, N }
        * } }
        * 
        * System.out.println("-> ck_id: " + ck_id);
        * 
        * mav.addObject("ck_id", ck_id); mav.addObject("ck_id_save", ck_id_save);
        * mav.addObject("ck_passwd", ck_passwd); mav.addObject("ck_passwd_save",
        * ck_passwd_save); //
        * -----------------------------------------------------------------------------
        * --
        */       
       return mav;
     }
     
     /**
      * 수정 폼
      * http://localhost:9091/product/update_text.do?productno=1
      * 
      * @return
      */
     @RequestMapping(value = "/product/update_text.do", method = RequestMethod.GET)
     public ModelAndView update_text(int productno) {
       ModelAndView mav = new ModelAndView();
       
       ProductVO productVO = this.productProc.read_update_text(productno);
       BookVO bookVO = this.bookProc.read(productVO.getBookno());
       BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
       
       mav.addObject("productVO", productVO);
       mav.addObject("bookVO", bookVO);
       mav.addObject("bookgrpVO", bookgrpVO);
       
       mav.setViewName("/product/update_text"); // /WEB-INF/views/product/update_text.jsp
       // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
       // mav.addObject("content", content);

       return mav; // forward
     }
     
     /**
      * 수정 처리
      * http://localhost:9091/product/update_text.do?productno=1
      * 
      * @return
      */
     @RequestMapping(value = "/product/update_text.do", method = RequestMethod.POST)
     public ModelAndView update_text(ProductVO productVO,
                                                        @RequestParam(value = "now_page", defaultValue = "1") int now_page) {
       ModelAndView mav = new ModelAndView();
       
       int cnt = this.productProc.update_text(productVO); // 수정 처리
       
       mav.addObject("productno", productVO.getProductno());
       mav.addObject("now_page", now_page);
       
       mav.setViewName("redirect:/product/read.do"); // 전송된 form 데이터는 모두 삭제됨.

       return mav; // forward
     }
     
     /**
      * 파일 수정 폼
      * http://localhost:9091/product/update_file.do?productno=1
      * 
      * @return
      */
     @RequestMapping(value = "/product/update_file.do", method = RequestMethod.GET)
     public ModelAndView update_file(int productno) {
       ModelAndView mav = new ModelAndView();
       
       ProductVO productVO = this.productProc.read(productno);
       BookVO bookVO = this.bookProc.read(productVO.getBookno());
       BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
       
       mav.addObject("productVO", productVO);
       mav.addObject("bookVO", bookVO);
       mav.addObject("bookgrpVO", bookgrpVO);
       
       mav.setViewName("/product/update_file"); // /WEB-INF/views/product/update_file.jsp

       return mav; // forward
     }

     /**
      * 파일 수정 처리 http://localhost:9091/product/update_file.do
      * 
      * @return
      */
     @RequestMapping(value = "/product/update_file.do", method = RequestMethod.POST)
     public ModelAndView update_file(HttpServletRequest request, ProductVO productVO) {
       ModelAndView mav = new ModelAndView();

       // -------------------------------------------------------------------
       // 파일 삭제 코드 시작
       // -------------------------------------------------------------------
       // 삭제할 파일 정보를 읽어옴.
       ProductVO vo = productProc.read(productVO.getProductno());
//       System.out.println("productno: " + vo.getproductno());
//       System.out.println("file1: " + vo.getFile1());
       
       String file1saved = vo.getFile1saved();
       String thumb1 = vo.getThumb1();
       long size1 = 0;
       boolean sw = false;
       
       // 완성된 경로 F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/product/storage/
       String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/product/storage/"; // 절대 경로

       sw = Tool.deleteFile(upDir, file1saved);  // Folder에서 1건의 파일 삭제
       sw = Tool.deleteFile(upDir, thumb1);     // Folder에서 1건의 파일 삭제
       // System.out.println("sw: " + sw);
       // -------------------------------------------------------------------
       // 파일 삭제 종료 시작
       // -------------------------------------------------------------------
       
       // -------------------------------------------------------------------
       // 파일 전송 코드 시작
       // -------------------------------------------------------------------
       String file1 = "";          // 원본 파일명 image

       // 완성된 경로 F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/product/storage/
       // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/product/storage/"; // 절대 경로
       
       // 전송 파일이 없어도 fnamesMF 객체가 생성됨.
       // <input type='file' class="form-control" name='file1MF' id='file1MF' 
       //           value='' placeholder="파일 선택">
       MultipartFile mf = productVO.getFile1MF();
       
       file1 = mf.getOriginalFilename(); // 원본 파일명
       size1 = mf.getSize();  // 파일 크기
       
       if (size1 > 0) { // 파일 크기 체크
         // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
         file1saved = Upload.saveFileSpring(mf, upDir); 
         
         if (Tool.isImage(file1saved)) { // 이미지인지 검사
           // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
           thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
         }
         
       }    
       
       productVO.setFile1(file1);
       productVO.setFile1saved(file1saved);
       productVO.setThumb1(thumb1);
       productVO.setSize1(size1);
       // -------------------------------------------------------------------
       // 파일 전송 코드 종료
       // -------------------------------------------------------------------
       
       // Call By Reference: 메모리 공유, Hashcode 전달
       int cnt = this.productProc.update_file(productVO);
       
       mav.addObject("productno", productVO.getProductno());
       
       mav.setViewName("redirect:/product/read.do"); 

       return mav; // forward
     }

     
     /**
      * 삭제 폼
      * @param productno
      * @return
      */
     @RequestMapping(value="/product/delete.do", method=RequestMethod.GET )
     public ModelAndView delete(int productno) { 
       ModelAndView mav = new  ModelAndView();
       
       // 삭제할 정보를 조회하여 확인
       ProductVO productVO = this.productProc.read(productno);
       mav.addObject("productVO", productVO);     
       mav.setViewName("/product/delete");  // product/delete.jsp
       
       return mav; 
     }
     
     /**
      * 삭제 처리 http://localhost:9091/product/delete.do
      * 
      * @return
      */
     @RequestMapping(value = "/product/delete.do", method = RequestMethod.POST)
     public ModelAndView delete(HttpServletRequest request, int productno) {
       ModelAndView mav = new ModelAndView();

       // -------------------------------------------------------------------
       // 파일 삭제 코드 시작
       // -------------------------------------------------------------------
       // 삭제할 파일 정보를 읽어옴.
       ProductVO vo = productProc.read(productno);
//       System.out.println("productno: " + vo.getproductno());
//       System.out.println("file1: " + vo.getFile1());
       
       String file1saved = vo.getFile1saved();
       String thumb1 = vo.getThumb1();
       long size1 = 0;
       boolean sw = false;
       
       // 완성된 경로 F:/ai8/ws_frame/resort_v1sbm3a/src/main/resources/static/product/storage/
       String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/product/storage/"; // 절대 경로

       sw = Tool.deleteFile(upDir, file1saved);  // Folder에서 1건의 파일 삭제
       sw = Tool.deleteFile(upDir, thumb1);     // Folder에서 1건의 파일 삭제
       // System.out.println("sw: " + sw);
       // -------------------------------------------------------------------
       // 파일 삭제 종료 시작
       // -------------------------------------------------------------------
       
       int cnt = this.productProc.delete(productno); // DBMS 삭제
       
       mav.setViewName("redirect:/product/list_by_bookno_search_paging.do"); 

       return mav; // forward
     }  
     
     /**
      * 판매 여부 수정 처리
      * http://localhost:9091/product/update_stateno.do?productno=1
      * 
      * @return
      */
     @RequestMapping(value = "/product/update_stateno.do", method = RequestMethod.POST)
     public ModelAndView update_stateno(int productno) {
       ModelAndView mav = new ModelAndView();
       
       int cnt = this.productProc.update_stateno(productno); // 수정 처리

       
       mav.setViewName("/message/list"); 

       return mav; // forward
     }
        
     

}