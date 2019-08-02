package edu.autocar.socket.handler;

import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import edu.autocar.socket.model.Message;

public class CarHandler extends TextWebSocketHandler{

	//POSITION Map
	Map<Integer, List<WebSocketSession>> sMap = Collections.synchronizedMap(new HashMap<>());
	
	//CONTROL Map
	Map<Integer, List<WebSocketSession>> cMap = Collections.synchronizedMap(new HashMap<>());
	
	//DETECTION Map
	Map<Integer, List<WebSocketSession>> dMap = Collections.synchronizedMap(new HashMap<>());
	
	//LOG Map
	Map<Integer, List<WebSocketSession>> lMap = Collections.synchronizedMap(new HashMap<>());
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String rcvMsg = message.getPayload();
		//System.out.println(rcvMsg);
		Gson g = new Gson();
		Message carMsg = g.fromJson(rcvMsg, Message.class);
		System.out.println(rcvMsg);
		int target = carMsg.getTarget();

		List<WebSocketSession> list;
		
		switch(carMsg.getMsgType()) {
		
		case "STATUS_SUB":
			addPositionObserver(target, session);
			break;
		case "STATUS":
			list = sMap.get(target);
			if(list != null) {
				for(WebSocketSession s : list) {
					s.sendMessage(message);
				}
			}
			break;
		case "CONTROL_SUB":
			addControlObserver(target, session);
			
			break;
		case "CONTROL":
			list = cMap.get(target);
			if(list != null) {
				for(WebSocketSession s : list) {
					s.sendMessage(message);
				}
			}
			break;
			
		case "LOG_SUB":
			addLogObserver(target, session);
			
			break;
		case "LOG":
			list = lMap.get(target);
			if(list != null) {
				for(WebSocketSession s : list) {
					s.sendMessage(message);
				}
			}
			break;
		
		case "DETECTION_SUB":
			addDetectionObserver(target, session);
			
			break;
		case "DETECTION":
			list = dMap.get(target);
			if(list != null) {
				for(WebSocketSession s : list) {
					s.sendMessage(message);
				}
			}
			break;
		}
		
	}

	void addPositionObserver(int target, WebSocketSession session) {
		List<WebSocketSession> list = sMap.get(target);
		if(list==null) {
			list = new LinkedList<>();
			sMap.put(target, list);
		}
		list.add(session);
	}
	
	void addControlObserver(int target, WebSocketSession session) {
		List<WebSocketSession> list = cMap.get(target);
		if(list==null) {
			list = new LinkedList<>();
			cMap.put(target, list);
		}
		list.add(session);
	}
	

	void addLogObserver(int target, WebSocketSession session) {
		List<WebSocketSession> list = lMap.get(target);
		if(list==null) {
			list = new LinkedList<>();
			lMap.put(target, list);
		}
		list.add(session);
	}
	
	void addDetectionObserver(int target, WebSocketSession session) {
		List<WebSocketSession> list = dMap.get(target);
		if(list==null) {
			list = new LinkedList<>();
			dMap.put(target, list);
		}
		list.add(session);
	}
	
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception { 
		super.afterConnectionClosed(session, status);
		
		for(int target : sMap.keySet()) {
			List<WebSocketSession> list = sMap.get(target);
			if(list.remove(session))
				break;
		}
		
		for(int target : cMap.keySet()) {
			List<WebSocketSession> list = cMap.get(target);
			if(list.remove(session))
				break;
		}
		
		for(int target : lMap.keySet()) {
			List<WebSocketSession> list = lMap.get(target);
			if(list.remove(session))
				break;
		}
		
		for(int target : dMap.keySet()) {
			List<WebSocketSession> list = dMap.get(target);
			if(list.remove(session))
				break;
		}
	}
}
