package chit.chat;

import java.util.Stack;

public class ChatRooms extends Stack
{
	private String name;
	private String description;
	public ChatRooms (String name, String description, int size)
	{
		this.name=name;
		this.description=description;
		setSize(size);
	}
	public void joinChatEntry(ChatRoomEntry chatentry)
	{
		push(chatentry);
	}
	public String getDescription()
	{
		return description;
	}
	public String getName()
	{
		return name;
	}
}
