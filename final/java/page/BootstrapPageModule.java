package com.hobbycam.page;

public class BootstrapPageModule {

   public static String pageMake(String pageName, int totalCnt, int listSize, int pageSize, int cp) {

      // Total Page
      int totalPage = (totalCnt/listSize) + 1;
      if(totalCnt%listSize==0) totalPage--;

      // 현재 페이지그룹 (시작은 0부터)
      int pageGroup = cp/pageSize;
      if(cp%pageSize==0) pageGroup--;

      // 총 페이지 그룹
      int totalPageGroup = totalPage/pageSize;
      if(totalPage%pageSize==0) totalPageGroup--;
      
      // 한 페이지그룹의 시작, 끝 index
      int startIdx = pageSize * pageGroup + 1 ;
      int endIdx = pageSize * pageGroup + pageSize;

      int beforeIdx = (pageGroup-1) * pageSize + pageSize; //이전 페이지 index
      int nextIdx = (pageGroup+1) * pageSize + 1; //다음 페이지 index
      
      StringBuffer sb = new StringBuffer();
      
      sb.append("<nav aria-label='pagination'>");
      sb.append("<ul class='pagination justify-content-center'>");
      
      /*Previous*/
      if(pageGroup!=0){
         sb.append("<li class='page-item'><a class='page-link' href='");
         sb.append(pageName);
         sb.append("?cp=");
         sb.append(beforeIdx);
         sb.append("'>&laquo;</a></li>");   
      }

      /*Page List*/
      for(int i=startIdx; i<=endIdx; i++){
         sb.append("<li class='page-item ");
         if(cp==i) sb.append("active");
         sb.append("'><a class='page-link' href='");
         sb.append(pageName);
         sb.append("?cp=");
         sb.append(i);
         sb.append("'>");
         sb.append(i);
         sb.append("</a></li>");
         
         if(i==totalPage) break;
      }

      /*Next*/
      if(pageGroup!=totalPageGroup){
         
         sb.append("<li class='page-item'><a class='page-link' href='");
         sb.append(pageName);
         sb.append("?cp=");
         sb.append(nextIdx);
         sb.append("'>&raquo;</a></li></ul></nav>");
      }

      return sb.toString();
      
   }
}

