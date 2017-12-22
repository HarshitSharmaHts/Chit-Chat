package chit.chat;

public class ChatRoomEntry{
  private String profileName;
  private String message;

  public ChatRoomEntry (String profileName, String message)
  {
    this.profileName = profileName;
    this.message = message;
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
}
