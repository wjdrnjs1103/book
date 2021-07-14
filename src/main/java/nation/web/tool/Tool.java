// version 1.0
package nation.web.tool;

public class Tool {
  /**
   * 문자열이 null이면 ""으로 변경
   * @param str
   * @return
   */
  public static synchronized String checkNull(String str) {
    if (str == null) {
      str = "";
    }
    
    return str;
  }
  
}