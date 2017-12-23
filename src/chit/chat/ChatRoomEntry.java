package chit.chat;

public class ChatRoomEntry{
  private String profileName;
  private String message;
  private String time;

  public ChatRoomEntry (String profileName, String message, String time)
  {
    this.profileName = profileName;
    this.message = message;
    this.time = time;
  }
  public String getProfileName()
  {
    return profileName;
  }
  public void setprofileName(String str)
  {
    profileName=str;
  }
  public String getMessage()
  {
    return message;
  }
  public String getTime()
  {
    return time;
  }
}
