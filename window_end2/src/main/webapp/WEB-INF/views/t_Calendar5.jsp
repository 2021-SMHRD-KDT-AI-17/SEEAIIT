<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8' />
  <!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  <!-- jquery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- fullcalendar CDN -->
  <link href='resources/assets/css/Calendarcss.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
    <!-- axios -->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <!-- 부트스트랩CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <!-- 부트스트랩CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
	<link rel="stylesheet" href="https://unpkg.com/98.css">
<style>
  /* body 스타일 */
  html, body {
    overflow: hidden;
    /* font-family: Arial, Helvetica Neue, Helvetica, sans-serif; */
    font-size: 13px;
    color:black;
  }

  .fc-daygrid-day-number, .fc-toolbar-title,.fc-col-header-cell-cushion {
    color: black !important; /* 월과 날짜의 색상을 검정색으로 변경 */
  }
  .fc-toolbar-title{
    font-weight: bolder;
  } 
  /* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
  .fc-header-toolbar {
    padding-top: 1em;
    padding-left: 1em;
    padding-right: 1em;
  }
  dialog{
    position:fixed;
    width:300px;
    z-index:100;
    padding: 30px;
    background : #fff;
    left:50%;
    top:50%;
    transform: translate(-50%,-50%);
    box-shadow: 2px 2px 5px rgba(0,0,0,.5);
    border:none;
    border-radius: 10px;
  }
  .fc-event {
    border-color: transparent !important; /* 테두리 색상을 투명하게 설정 */
  }
  .dialog-dday {
    font-weight: bold;
    font-size: 16px; /* 원하는 크기로 조절하세요 */
  }
</style>
<link href="resources/assets/css/Calendarcss.css" rel="stylesheet">
</head>
<body style="padding:30px;">

  <!-- calendar 태그 -->
  <div id='calendar-container'>
    
    <div id='calendar'></div>
  </div>
      <!-- 부트스트랩 modal 부분 -->
    <!-- Modal -->
    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">일정 추가하기</h5>
            <button
              type="button"
              data-bs-dismiss="modal"
              aria-label="Close"
            >X</button>
          </div>
          <div class="modal-body">
            일정이름 : <input type="text" id="title" /><br />
            시작시간 : <input type="datetime-local" id="start" /><br />
            종료시간 : <input type="datetime-local" id="end" /><br />
            배경색상 :
            <select id="color">
              <option value="red">빨강색</option>
              <option value="orange">주황색</option>
              <option value="yellow">노랑색</option>
              <option value="green">초록색</option>
              <option value="blue">파랑색</option>
              <option value="indigo">남색</option>
              <option value="purple">보라색</option>
            </select>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              data-bs-dismiss="modal"
            >
              취소
            </button>
            <button type="button" id="saveChanges">
              추가
            </button>
          </div>
        </div>
      </div>
    </div>
  <script>

  
  
  (function(){
    $(function(){
        // dialog 팝업창
      let popup = document.querySelector('dialog');
      var selectedEvent; 
      var isNewEvent = false;
      // calendar element 취득
      var calendarEl = $('#calendar')[0];
      // full-calendar 생성하기
      var calendar = new FullCalendar.Calendar(calendarEl, {
        googleCalendarApiKey: 'AIzaSyBo_cno4cgNxMOKOUVv_bIAuRKp-3KaHAs',// 여기에 구글캘린더 api키 입력하시면 됩니다.
        events: {
                googleCalendarId: '2b8d95d6fedf264947b6114d2428c025138669c6bd5a866f955d2937d99196f4@group.calendar.google.com'
                
            },



        height: '700px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        
        customButtons:{

        	myCustomButton:{
        	    text: "일정 추가하기",
        	    click: function() {
        	        // admin 여부 확인
        	        var isAdmin = /0/.test("${loginMember.rank_num}");

        	        if (isAdmin) {
        	            // 부트스트랩 모달 열기
        	            $("#exampleModal").modal("show");
        	        } else {
        	            alert("팀장만 일정을 추가할 수 있습니다.");
        	        }
        	    }
        	},
        	mySaveButton: {
        	    text: "저장하기",
        	    click: function() {
        	        // 관리자 여부 확인
        	        var isAdmin = /0/.test("${loginMember.rank_num}");


        	        if (isAdmin) {
        	            if (confirm("저장하시겠습니까?")) {
        	                var allEvent = calendar.getEvents();
        	                var eventData = [];
        	                allEvent.forEach(function(event) {
        	                    eventData.push({
        	                        title: event.title,
        	                        start: event.startStr,
        	                        end: event.endStr,
        	                        backgroundColor: event.backgroundColor
        	                    });
        	                });
        	                console.log(eventData);
        	                $.ajax({
        	                    type: "POST",
        	                    url: "tsaveEvents5",
        	                    data: JSON.stringify(eventData),
        	                    contentType: "application/json",
        	                    success: function(res) {
        	                        console.log(res);
        	                        alert("이벤트가 성공적으로 저장되었습니다.");
        	                        // 이벤트 저장 후 캘린더 새로고침
        	                        // calendar.refetchEvents();
        	                    },
        	                    error: function(xhr, status, error) {
        	                        console.error("서버 요청 실패:", error);
        	                        
        	                    }
        	                });
        	            }
        	        } else {
        	            alert("팀장만 이벤트를 저장할 수 있습니다.");
        	        }
        	    }
        	},
          
          firstButton: {
        	    text: "정처기1차",
        	    click: function() {
        	        $.ajax({
        	            type: "POST",
        	            url: "Test1", // 실제 서블릿 또는 컨트롤러 URL로 대체해야 합니다.
        	            contentType: "application/json",
        	            success: function(res) {
        	                console.log(res); // 가져온 데이터를 콘솔에 출력
        	                alert("1차 정보처리기사 시험 일정을 불러왔습니다");

        	                // 이전에 추가된 이벤트 소스를 모두 삭제
        	                calendar.getEventSources().forEach(function(eventSource) { 
        	                    eventSource.remove(); 
        	                });

        	                // 새로운 이벤트 소스 추가
        	                calendar.addEventSource(res);
        	            },
        	            error: function(xhr, status, error) {
        	                console.error("서버 요청 실패:", error);
        	                alert("실패했습니다.");
        	            }
        	        });
        	    }
          },
          secondButton: {
      	    text: "정처기2차",
      	    click: function() {
      	        $.ajax({
      	            type: "POST",
      	            url: "Test3", // 실제 서블릿 또는 컨트롤러 URL로 대체해야 합니다.
      	            contentType: "application/json",
      	            success: function(res) {
      	                console.log(res); // 가져온 데이터를 콘솔에 출력
      	                alert("2차 정보처리기사 시험 일정을 불러왔습니다");

      	                // 이전에 추가된 이벤트 소스를 모두 삭제
      	                calendar.getEventSources().forEach(function(eventSource) { 
      	                    eventSource.remove(); 
      	                });

      	                // 새로운 이벤트 소스 추가
      	                calendar.addEventSource(res);
      	            },
      	            error: function(xhr, status, error) {
      	                console.error("서버 요청 실패:", error);
      	                alert("실패했습니다.");
      	            }
      	        });
      	    }
        },
        
        thirdButton: {
      	    text: "정처기3차",
      	    click: function() {
      	        $.ajax({
      	            type: "POST",
      	            url: "Test4", // 실제 서블릿 또는 컨트롤러 URL로 대체해야 합니다.
      	            contentType: "application/json",
      	            success: function(res) {
      	                console.log(res); // 가져온 데이터를 콘솔에 출력
      	                alert("3차 정보처리기사 시험 일정을 불러왔습니다");

      	                // 이전에 추가된 이벤트 소스를 모두 삭제
      	                calendar.getEventSources().forEach(function(eventSource) { 
      	                    eventSource.remove(); 
      	                });

      	                // 새로운 이벤트 소스 추가
      	                calendar.addEventSource(res);
      	            },
      	            error: function(xhr, status, error) {
      	                console.error("서버 요청 실패:", error);
      	                alert("실패했습니다.");
      	            }
      	        });
      	    }
        },
          
        CalButton: {
      	    text: "반캘린더",
      	    click: function() {
      	        // 원래 캘린더 데이터를 다시 불러와서 캘린더를 초기화
      	        $.ajax({
      	            type: "POST", // POST 요청을 통해 데이터를 받아옴
      	            url: "Test2", // 캘린더 데이터를 반환하는 엔드포인트 URL
      	            dataType: "json",
      	            success: function(Test2) {
      	                // 이벤트를 담을 배열 선언
      	                const eventArray = [];
      	                Test2.forEach(function(res) {
      	                    eventArray.push({
      	                        title: res.title,
      	                        start: res.start,
      	                        end: res.end,
      	                        backgroundColor: res.backgroundColor,
      	                    });
      	                });
      	                
      	                // 캘린더 초기화 및 새로운 이벤트 소스 추가
      	                calendar.removeAllEvents();
      	                calendar.addEventSource(eventArray);
      	                
      	                // 성공 메시지 표시
      	                alert("반 캘린더 화면으로 갑니다");
      	            },
      	            error: function(xhr, status, error) {
      	                // 오류 처리
      	                console.error("서버 요청 실패:", error);
      	                alert("반 캘린더 화면 로딩이 실패했습니다.");
      	            }
      	        });
      	    }
      	},
        
        returnButton: {
      	    text: "돌아가기",
      	    click: function() {
      	        // 원래 캘린더 데이터를 다시 불러와서 캘린더를 초기화
      	        $.ajax({
      	            type: "POST", // POST 요청을 통해 데이터를 받아옴
      	            url: "tTest25", // 캘린더 데이터를 반환하는 엔드포인트 URL
      	            dataType: "json",
      	            success: function(Test2) {
      	                // 이벤트를 담을 배열 선언
      	                const eventArray = [];
      	                Test2.forEach(function(res) {
      	                    eventArray.push({
      	                        title: res.title,
      	                        start: res.start,
      	                        end: res.end,
      	                        backgroundColor: res.backgroundColor,
      	                    });
      	                });
      	                
      	                // 캘린더 초기화 및 새로운 이벤트 소스 추가
      	                calendar.removeAllEvents();
      	                calendar.addEventSource(eventArray);
      	                
      	                // 성공 메시지 표시
      	                alert("원래 캘린더로 돌아왔습니다.");
      	            },
      	            error: function(xhr, status, error) {
      	                // 오류 처리
      	                console.error("서버 요청 실패:", error);
      	                alert("원래 캘린더를 불러오는데 실패했습니다.");
      	            }
      	        });
      	    }
      	}

      
      },
      eventClick: function(event) {
          console.log("이벤트클릭");

          // 선택한 이벤트 정보를 전역 변수에 저장합니다.
          selectedEvent = event;

          // 이벤트의 시작 날짜 가져오기
          var eventStartDate = event.event.start;

          // 현재 날짜 가져오기
          var currentDate = new Date();

          // D-day 계산
          var timeDiff = eventStartDate.getTime() - currentDate.getTime();
          var dayDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));

          // D-day 표시 문자열 설정
          var dDayString = '';
          if (dayDiff > 0) {
              dDayString = 'D-' + dayDiff; // 이벤트가 남은 경우
          } else if (dayDiff === 0) {
              dDayString = 'D-day'; // 이벤트가 오늘인 경우
          } else {
              dDayString = 'D+' + Math.abs(dayDiff); // 이벤트가 지난 경우
          }

          // 선택한 이벤트의 정보를 모달에 표시합니다.
          $("#eventInfoTitle").text(event.event.title);
          $("#eventInfoStart").text(event.event.startStr);
          $("#eventInfoEnd").text(event.event.endStr);
          $("#eventInfoDday").text(dDayString);

          // 부트스트랩 모달 열기
          $("#eventInfoModal").modal("show");
      },
      

      // 해더에 표시할 툴바
      headerToolbar: {
        left: 'prev,next today,myCustomButton,mySaveButton',
        center: 'title',
        right: 'firstButton,secondButton,thirdButton,CalButton,returnButton'
      },
      initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
      // initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
      navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
      editable: true, // 수정 가능?
      selectable: true, // 달력 일자 드래그 설정가능
      nowIndicator: true, // 현재 시간 마크
      dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
      locale: 'ko', // 한국어 설정
      eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
        console.log(obj);
      },
      eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
        console.log(obj);
      },
      eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
        console.log(obj);
      },
      select: function(arg) {
      	  // 현재 로그인한 사용자가 admin 인지 확인
      	        var isAdmin = /0/.test("${loginMember.rank_num}");


      	  if (isAdmin) {
      	    var title = prompt('Event Title:');
      	    if (title) {
      	      calendar.addEvent({
      	        title: title,
      	        start: arg.start,
      	        end: arg.end,
      	        allDay: arg.allDay
      	      })
      	    }
      	  } else {
      	    alert("팀장만 이벤트를 생성할 수 있습니다.");
      	  }

      	  calendar.unselect();
      	},
        //데이터 가져오는 이벤트
eventSources: [
    // 데이터베이스에서 가져온 캘린더 정보를 이벤트로 추가합니다.
 	{
	    events: function(info, successCallback, failureCallback) {
	        $.ajax({
	            url: "tTest25",
	      	  	dataType:"json",
	            success: function(Test2) {
	                // 이벤트에 넣을 배열 선언하기
	                const eventArray = [];
	                Test2.forEach(function(res) {
	                    eventArray.push({
	                        title: res.title,
	                        start: res.start,
	                        end: res.end,
	                        backgroundColor: res.backgroundColor,
	                    });
	                });
	                successCallback(eventArray);
	            },
	            error: function(xhr, status, error) {
	                console.error("서버 요청 실패:", error);
	                failureCallback(error);
	            }
	        });
	    }
	} 
        ]
      });

        
      //모달창 이벤트
      $("#saveChanges").on("click", function () {
            var eventData = {
              title: $("#title").val(),
              start: $("#start").val(),
              end: $("#end").val(),
              color: $("#color").val(),
            };
            //빈값입력시 오류
            if (
              eventData.title == "" ||
              eventData.start == "" ||
              eventData.end == ""
            ) {
              alert("입력하지 않은 값이 있습니다.");

              //끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
            } else if ($("#start").val() > $("#end").val()) {
              alert("시간을 잘못입력 하셨습니다.");
            } else {
              // 이벤트 추가
              calendar.addEvent(eventData);
              $("#exampleModal").modal("hide");
              $("#title").val("");
              $("#start").val("");
              $("#end").val("");
              $("#color").val("");
            }
          });
      // 캘린더 랜더링
      calendar.render();
      
      $("#deleteEventBtn").on("click", function() {
  	    var isAdmin = /0/.test("${loginMember.rank_num}"); // userEmail은 서버에서 받아온 사용자의 이메일입니다.

  	    if (isAdmin) {
  	        // 확인 다이얼로그를 통해 사용자에게 삭제 여부를 물어봅니다.
  	        if (confirm("이벤트를 삭제하시겠습니까?")) {
  	            // 선택한 이벤트의 정보를 가져옵니다.
  	            var title = selectedEvent.event.title;
  	            var start = selectedEvent.event.startStr;
  	            var end = selectedEvent.event.endStr;

  	            // AJAX를 사용하여 서버로 삭제 요청을 보냅니다.
  	            $.ajax({
  	                type: "POST",
  	                url: "tdeleteEvent5",
  	                contentType: "application/json",
  	                data: JSON.stringify({ 
  	                    title: title,
  	                    start: start,
  	                    end: end
  	                }), // 이벤트의 제목, 시작일, 종료일을 서버에 전달합니다.
  	                success: function(response) {
  	                    console.log("이벤트 삭제 요청 성공:", response);
  	                    
  	                    // 성공적으로 서버로부터 응답을 받았을 때, 캘린더에서 이벤트를 삭제합니다.
  	                    selectedEvent.event.remove(); // 캘린더에서 이벤트 삭제
  	                    $("#eventInfoModal").modal("hide"); // 모달 닫기
  	                },
  	                error: function(xhr, status, error) {
  	                    console.error("서버 요청 실패:", error);
  	                  
  	                }
  	            });
  	        }
  	    } else {
  	        alert("팀장만 이벤트를 삭제할 수 있습니다.");
  	    }
  	});
   
   
      popup.querySelector('button').addEventListener('click',()=>{
        popup.removeAttribute('open');
      });


    });
  })();
  function deleteEvent(eventId) {
	    var isAdmin = /0/.test("${loginMember.rank_num}");

	    if (isAdmin) {
	        if (confirm("이벤트를 삭제하시겠습니까?")) {
	            // 캘린더에서 이벤트 제거
	            calendar.getEventById(eventId).remove();
	            // 여기에서 이벤트를 삭제하는 추가적인 작업을 수행할 수 있습니다.
	            // 예: 서버로 이벤트 삭제 요청 보내기 등
	            // 추가 작업을 수행하려면 이 함수를 적절히 수정하세요.
	            // 이 함수에서 서버로 요청을 보내는 경우에는 AJAX 등을 사용하여 비동기적으로 처리할 수 있습니다.
	            // 서버에서 이벤트 삭제를 확인한 후에만 캘린더에서 이벤트를 삭제하는 것이 좋습니다.
	        }
	    } else {
	        alert("팀장만 이벤트를 삭제할 수 있습니다.");
	    }
	}

	// 모달에서 삭제 버튼 클릭 시 이벤트 삭제

</script>

  <div id="calendar1"></div>
  <dialog>
    <div>제목 테스트</div>
    <br>
    <button type="button" class="btn btn-secondary btn-sm">닫기</button>
  </dialog>
  
  <!-- 부트스트랩 modal 부분 -->
  
<div class="modal fade" id="eventInfoModal" tabindex="-1" aria-labelledby="eventInfoModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="eventInfoModalLabel"></h5>
        <button type="button" data-bs-dismiss="modal" aria-label="Close">X</button>
      </div>
      <div class="modal-body">
        <!-- 이벤트 정보가 여기에 들어갈 것입니다. -->
        <h3><span id="eventInfoTitle"></span></h3>
        <h5><span id="eventInfoDday"></span></h5>
      </div>
      <div class="modal-footer">
        <button type="button" id="deleteEventBtn" data-bs-dismiss="modal">삭제</button>
        <button type="button" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>