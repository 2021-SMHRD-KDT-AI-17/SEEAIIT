package kr.smhrd.mapper;

import java.util.ArrayList;


import kr.smhrd.entity.Calendar;
import kr.smhrd.entity.EventData;
import kr.smhrd.entity.tCalendar;
import kr.smhrd.entity.tCalendar2;
import kr.smhrd.entity.tCalendar3;
import kr.smhrd.entity.tCalendar4;
import kr.smhrd.entity.tCalendar5;

public interface CalendarMapper {
		void insertEvent(Calendar event);
		
		ArrayList<Calendar> CalList();

		ArrayList<tCalendar> tCalList();

		void tinsertEvent(tCalendar eventData);

		void deleteEvent(EventData eventData);

		void tdeleteEvent(EventData eventData);

		ArrayList<tCalendar2> tCalList2();

		void tinsertEvent2(tCalendar eventData);

		void tdeleteEvent2(EventData eventData);

		void tinsertEvent3(tCalendar eventData);

		ArrayList<tCalendar3> tCalList3();

		void tdeleteEvent3(EventData eventData);

		ArrayList<tCalendar4> tCalList4();

		void tinsertEvent4(tCalendar eventData);

		void tdeleteEvent4(EventData eventData);

		ArrayList<tCalendar5> tCalList5();

		void tinsertEvent5(tCalendar eventData);

		void tdeleteEvent5(EventData eventData);


}
