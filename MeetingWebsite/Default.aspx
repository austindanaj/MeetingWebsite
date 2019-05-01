<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MeetingWebsite._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        

  #calendar {
    max-width: 900px;
    margin: 0 auto;

  }

        a.submitButton {
           
            display: inline-block;
            padding: 0.35em 10em;
            border: 0.1em solid #FFFFFF;         
            border-radius: 0.12em;
            box-sizing: border-box;
            text-decoration: none;
            font-family: 'Roboto',sans-serif;
            font-weight: 300;
            cursor: pointer;
            color: #FFFFFF;
            text-align: center;
            transition: all 0.2s;
        }

            a.submitButton:hover {
                color: #004a7a;
                background-color: #FFFFFF;
            }

        @media all and (max-width:30em) {
             a.submitButton {
                display: block;
                margin: 0.4em auto;
            }
        }

        .bouncy {
            animation: bouncy 5s infinite linear;
            position: relative;
        }

        @keyframes bouncy {
            0% {
                top: 0em
            }

            40% {
                top: 0em
            }

            43% {
                top: -0.9em
            }

            46% {
                top: 0em
            }

            48% {
                top: -0.4em
            }

            50% {
                top: 0em
            }

            100% {
                top: 0em;
            }
        }



        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            padding-top: 200px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 0;
            border: 1px solid #888;
            width: 50%;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
            -webkit-animation-name: animatetop;
            -webkit-animation-duration: 0.4s;
            animation-name: animatetop;
            animation-duration: 0.4s
        }

        /* Add Animation */
        @-webkit-keyframes animatetop {
            from {
                top: -300px;
                opacity: 0
            }

            to {
                top: 0;
                opacity: 1
            }
        }

        @keyframes animatetop {
            from {
                top: -300px;
                opacity: 0
            }

            to {
                top: 0;
                opacity: 1
            }
        }

        /* The Close Button */
        .close {
            color: white;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }

        .modal-header {
            padding: 2px 16px;
            display: block;
            background-color: #004a7a;
            color: white;
        }

        .modal-body {
            padding: 2px 16px;
        }

        .modal-footer {
            display: block;
         
            background-color: #004a7a;
        }
        .errorDDL{
            margin-top: 15%;
            font-size: 12px;
            color: red;
        }
         .errorInput{
            margin-top: 8%;
            font-size: 12px;
            color: red;
        }
    </style>


    <div id="modalConfirm" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
            <div class="modal-header">
                <span class="close">&times;</span>
                <h2>Confirm the Reservation</h2>
            </div>
            <div class="modal-body">
                <div style="margin-bottom: 10px;">

             
                <h4>Please confirm your reservation below.</h4>
                       </div>
                <div  style="font-size: 20px;">

             
                <span style="margin-bottom: 10px;" >Item: <a style="font-weight: bold;" id="modalItemName"></a> </span>
                <br />
                <span style="margin-bottom: 10px;">Start: <a style="font-weight: bold;" id="modalStart"></a> </span>
                  <br />
                <span style="margin-bottom: 10px;">End: <a style="font-weight: bold;" id="modalEnd"></a> </span>
                   <br />
                <span style="margin-bottom: 10px;">Reason: <a style="font-weight: bold;" id="modalReason"></a> </span>
            </div>
            </div>
            <div class="modal-footer">
                  <img style="float: left" width="150" src="images/logo.png" alt="">
               <a onclick="submitReservation(); return false;" class="submitButton bouncy">Submit</a>
              
            </div>
        </div>
    </div>

    
    <div id="modalViewDetail" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
            <div class="modal-header">
                <span class="close">&times;</span>
                <h2  id="viewItem"></h2>
            </div>
            <div class="modal-body">                
                <div  style="font-size: 20px;">             
                
                <span style="margin-bottom: 10px;">Start: <a style="font-weight: bold;" id="viewStart"></a> </span>
                  <br />
                <span style="margin-bottom: 10px;">End: <a style="font-weight: bold;" id="viewEnd"></a> </span>
                             <br />
                <span style="margin-bottom: 10px;">Name: <a style="font-weight: bold;" id="viewName"></a> </span>
                   <br />
                <span style="margin-bottom: 10px;">Reason: <a style="font-weight: bold;" id="viewReason"></a> </span>
            </div>
            </div>
            <div class="modal-footer">
                  <img style="float: left" width="150" src="images/logo.png" alt="">
              <!-- <a onclick="submitReservation(); return false;" class="submitButton bouncy">Submit</a>-->
              
            </div>
        </div>
    </div>

    <div class="home">
        <!-- Home Slider -->
        <div class="home_slider_container">
            <div class="owl-carousel owl-theme home_slider">
                <!-- Slide -->
                <div class="owl-item">
                    <div class="home_slider_background" style="background-image: url(images/Background.png)"></div>
                    <div class="slide_container">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="slide_content">
                                        <div class="home_subtitle">ALNA Engineering</div>
                                        <div class="home_title">Reservation System</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Home Search -->
    <asp:UpdatePanel ID="pnlDropdowns" runat="server">
        <ContentTemplate>
            <div class="home_search">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_search_container">
                                <div class="home_search_content">
                                    <div class="search_form d-flex flex-row align-items-start justfy-content-start">
                                        <div class="search_form_content d-flex flex-row align-items-start justfy-content-start flex-wrap">
                                            <div>
                                                <select onchange="if(this.selectedIndex) onSelectType();" id="ddlRoomType" class="search_form_select" required="required"></select>
                                              <p class="errorDDL" id="errRoomType"></p>
                                            </div>
                                            <div>
                                                <select id="ddlItemName" class="search_form_select" required="required"></select>
                                           <p class="errorDDL" id="errItem"></p>
                                            </div>
                                            <div>
                                                <input required="required" autocomplete="off" style="top: 25%; position: relative; width: 92%;" type='text' class="form-control" id='dtpStartDate' placeholder="Start DateTime" data-date-format="M. d, yyyy - H:ii p" />
                                               <p class="errorInput" id="errStart"></p>
                                            </div>
                                            <div>
                                                <input required="required" autocomplete="off" style="top: 25%; position: relative; width: 92%;" type='text' class="form-control" id='dtpEndDate' placeholder="End DateTime" data-date-format="M. d, yyyy - H:ii p" />
                                           <p class="errorInput" id="errEnd"></p>
                                            </div>
                                            <div>
                                                <input required="required" autocomplete="off" style="top: 25%; position: relative; width: 92%;" type='text' class="form-control" id='txtComment' placeholder="Reason" />
                                               <p class="errorInput" id="errReason"></p>
                                            </div>

                                        </div>
                                        <button onclick="showConfirmation(); return false;" class="search_form_button ml-auto">Submit</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div class="recent">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="section_title">View Reservations</div>
                    <div class="section_subtitle">Check out current reservations</div>
                </div>
            </div>
            <div class="row recent_row">
                <div class="col">
                    <div class="recent_slider_container">
                        <div class="owl-carousel owl-theme recent_slider">


                            <asp:Repeater ID="rptCarousel" runat="server">
                                <ItemTemplate>
                                    <div class="owl-item" style="cursor: pointer;" onclick="viewDetails(<%# Eval("Id") %>); return false;">
                                        <div class="recent_item">
                                            <div class="recent_item_inner">
                                                <div class="recent_item_image">
                                                    <div class="tag_featured property_tag"></a></div>
                                                </div>
                                                <div class="recent_item_body text-center">
                                                    <div class="recent_item_location"><%# string.Format("{0:M/d/yyyy}",  Eval("Date_Created")) %></div>
                                                    <div class="recent_item_title"><a style="cursor: pointer;"><%# Eval("Name") %></a></div>
                                                    <div class="recent_item_price"><%# Eval("Emp_Name") %></div>
                                                </div>
                                                <div class="recent_item_footer d-flex flex-row align-items-center justify-content-start">
                                                    <div style="margin: auto;">

                                                        <span><%# string.Format("{0:MMM. d, yyyy hh:mm tt}",Eval("Start_DateTime")) %></span>
                                                    </div>
                                                    <div style="margin: auto;">

                                                        <span><%# string.Format("{0:MMM. d, yyyy hh:mm tt}",Eval("End_DateTime")) %></span>
                                                    </div>
                                                    <div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <div class="owl-item">
                                <div class="recent_item">
                                    <div class="recent_item_inner">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="recent_slider_nav_container d-flex flex-row align-items-start justify-content-start">
                            <div class="recent_slider_nav recent_slider_prev"><i class="fa fa-chevron-left" aria-hidden="true"></i></div>
                            <div class="recent_slider_nav recent_slider_next"><i class="fa fa-chevron-right" aria-hidden="true"></i></div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>



 <div id='calendar'></div>
    <br />
    <br />

        <!--
      <iframe width="80%" height="600" src="https://app.powerbi.com/view?r=eyJrIjoiY2FjYTg5ODktMzEyNS00MDMwLThmZGQtZmRiZTA3N2VkNDkwIiwidCI6IjU3ZTc2OTk4LTc3YmQtNGI4Mi1hNDI0LTE5OGY0NmViMjI1NCIsImMiOjEwfQ%3D%3D" frameborder="0" allowFullScreen="true"></iframe>    </div>
        -->

    <input type="hidden" id="startDateTime" value="" />
    <input type="hidden" id="endDateTime" value="" />
    <script type="text/javascript">
        var MinDate = new Date().getTime();
        $(function () {
            //Date For Timer Edit
            $('#dtpStartDate').datetimepicker({
                weekStart: 1,
                todayBtn: 1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                forceParse: 0,
                minuteStep: 15,
                showMeridian: 1,
                forceParse: true



            });

            $("#dtpStartDate")
                .datetimepicker()
                .on('changeDate', function (e) {
                    $('#dtpEndDate').datetimepicker('setStartDate', e.date);
                    var x = e.date.format('MM dd yyyy hh:mm:00 tt'); /*e.date._d;*/
                    var y = document.getElementById('startDateTime');
                    y.value = x;
                });

            $('#dtpEndDate').datetimepicker({
                weekStart: 1,
                todayBtn: 1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                forceParse: 0,
                minuteStep: 15,
                showMeridian: 1

            });

            $("#dtpEndDate")
                .datetimepicker()
                .on('changeDate', function (e) {
                    $('#dtpStartDate').datetimepicker('setEndDate', e.date);

                    var x = e.date.format('MM dd yyyy hh:mm:00 tt'); /*e.date._d;*/
                    var y = document.getElementById('endDateTime');
                y.value = x;
                });
        });


        $(function () {
            PopulateItemTypes();
        });

        function PopulateItemTypes() {
          //  http://localhost:58929/api/ReservationTypes
            //"http://ahm43/connectivitywebapi/api/Authentication"
            $.ajax({
                type: "get",
                url: "http://ahm43/connectivitywebapi/api/ReservationTypes",
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                    OnDDLTypeSuccess(result);
                },
                error: function (xhr, status, error) {
                    OnDDLTypeFailure(error);
                },

            });
        }
        function OnDDLTypeSuccess(result) {
            var ddlType = document.getElementById('ddlRoomType');
            ddlType.length = 0;
            var option = document.createElement('option');
            option.value = "";
            option.text = '-- Select a Type --';
            ddlType.add(option);


            var ddlItem = document.getElementById('ddlItemName');
            ddlItem.length = 0;
            var option = document.createElement('option');
            option.value = "";
            option.text = 'Select Type First';
            ddlItem.add(option);


            for (var i = 0; i < result.length; i++) {
                var temp = document.createElement('option');
                temp.value = result[i].Id;
                temp.text = result[i].Type;
                ddlType.add(temp);
            }
        }
        function OnDDLTypeFailure(error) {
            var ddlType = document.getElementById('ddlRoomType');
            ddlType.length = 0;
            var option = document.createElement('option');
            option.value = "";
            option.text = 'Failed to load';
            ddlType.add(option);

            var ddlItem = document.getElementById('ddlItemName');
            ddlItem.length = 0;
            var option = document.createElement('option');
            option.value = "";
            option.text = 'Failed to load';
            ddlItem.add(option);
        }

        function onSelectType() {
            var ddlType = document.getElementById('ddlRoomType');

            var dataValue = { "id": parseInt(ddlType.value) };


            $.ajax({
                type: "get",
                url: '<%= ResolveUrl("http://ahm43/connectivitywebapi/api/ReservationItems") %>',
                contentType: "application/json; charset=utf-8",
                data: dataValue,
                success: function (result) {
                    OnDDLItemSuccess(result);
                },
                error: function (xhr, status, error) {
                    OnDDLItemFailure(error);
                },

            });
        }

        function OnDDLItemSuccess(result) {
            var ddlItem = document.getElementById('ddlItemName');
            ddlItem.length = 0;
            var option = document.createElement('option');
            option.value = "";
            option.text = '-- Select an Item --';
            ddlItem.add(option);

            for (var i = 0; i < result.length; i++) {
                var temp = document.createElement('option');
                temp.value = result[i].Id;
                temp.text = result[i].Name;
                ddlItem.add(temp);
            }
        }
        function OnDDLItemFailure(error) {
            var ddlItem = document.getElementById('ddlItemName');
            ddlItem.length = 0;
            var option = document.createElement('option');
            option.value = "";
            option.text = 'Failed to load';
            ddlItem.add(option);
        }


        var modalConfirm = document.getElementById('modalConfirm');
        var modalViewDetail = document.getElementById('modalViewDetail');
        // Get the <span> element that closes the modal
        var span1 = document.getElementsByClassName("close")[0];
        var span2 = document.getElementsByClassName("close")[1];

        // When the user clicks on <span> (x), close the modal
        span1.onclick = function () {
            modalConfirm.style.display = "none";
            //modalViewDetail.style.display = "none";
        }
        span2.onclick = function () {
            //modalConfirm.style.display = "none";
            modalViewDetail.style.display = "none";
        }
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modalConfirm) {
                modalConfirm.style.display = "none";
            } else if (event.target == modalViewDetail) {
                modalViewDetail.style.display = "none";
            }
        }
           
        function showConfirmation() {

            // show spinny wheel???


            let ddlRoomType = document.getElementById('ddlRoomType');     
            let ddlItem = document.getElementById('ddlItemName');           
            let startDateTime = document.getElementById('dtpStartDate');          
            let endDateTime = document.getElementById('dtpEndDate');            
            let reason = document.getElementById('txtComment');            


            if (ddlRoomType.options[ddlRoomType.selectedIndex].value == "") {
                document.getElementById("errRoomType").innerHTML = "Select a Type";
                return false;
            } else {
                document.getElementById("errRoomType").innerHTML = "";               
            }
            if (ddlItem.options[ddlItem.selectedIndex].value == "") {
                document.getElementById("errItem").innerHTML = "Select an Item";   
                return false;
            } else {
                document.getElementById("errItem").innerHTML = "";               
            }
            if (startDateTime.value == "") {
                document.getElementById("errStart").innerHTML = "Select a DateTime";
                return false;
            } else {
                document.getElementById("errStart").innerHTML = "";
            }
            if (endDateTime.value == "") {
                document.getElementById("errEnd").innerHTML = "Select a DateTime";
                return false;
            } else {
                document.getElementById("errEnd").innerHTML = "";
            }
            if (reason.value == "") {
                document.getElementById("errReason").innerHTML = "Enter a Reason";
                return false;
            } else {
                document.getElementById("errReason").innerHTML = "";
            }


            document.getElementById('modalItemName').innerHTML = ddlItem.options[ddlItem.selectedIndex].innerHTML;
            document.getElementById('modalStart').innerHTML = startDateTime.value;
            document.getElementById('modalEnd').innerHTML = endDateTime.value;
            document.getElementById('modalReason').innerHTML = reason.value;

            var getString = "itemId=" + ddlItem.options[ddlItem.selectedIndex].value + "&startDT=" + document.getElementById('startDateTime').value + "&endDT=" + document.getElementById('endDateTime').value;
      
            $.ajax({
                type: "get",
                url:"http://ahm43/connectivitywebapi/api/ReservationEntities?" + getString,
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                    OnConfirmationSuccess(result);
                },
                error: function (xhr, status, error) {
                    OnConfirmationFailure(error);
                },

              });
        }
        function OnConfirmationSuccess(result) {
            if (result == "") {
                modalConfirm.style.display = "block";
            } else {
                // show some alert that time conflicts
                alert("Error: Date/Time Conflict")
            }
        }
        function OnConfirmationFailure(error) {
            // show failed to check server, try again
            alert("Error: Failed to process request, please try again!")
        }

        function submitReservation() {
            let ddlItem = document.getElementById('ddlItemName');
            document.getElementById('modalItemName').innerHTML = ddlItem.options[ddlItem.selectedIndex].innerHTML;

            let startDateTime = document.getElementById('dtpStartDate');
            document.getElementById('modalStart').innerHTML = startDateTime.value;

            let endDateTime = document.getElementById('dtpEndDate');
            document.getElementById('modalEnd').innerHTML = endDateTime.value;

            let reason = document.getElementById('txtComment');
            document.getElementById('modalReason').innerHTML = reason.value;


            // make the below match ReservationEntry
            
            var dataValue = {
                "Alna_num": sessionStorage.getItem("Alna_num"), "Item_Id": ddlItem.options[ddlItem.selectedIndex].value, "Date_Created": new Date(), "Start_DateTime": document.getElementById('startDateTime').value, "End_DateTime": document.getElementById('endDateTime').value, "Comment": reason.value, "Active": 1};

            $.ajax({
                type: "post",
                url: "http://ahm43/connectivitywebapi/api/ReservationEntities",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(dataValue),
                success: function (result) {
                    // New Confirm methods
                    // Put success message, and reload page

                    //OnConfirmationSuccess(result);
                    onConfirmSubmitSuccess(result);
                },
                error: function (xhr, status, error) {
                     // New Fail methods
                     // Put fail message and show fail alert to try again. Also maybe keep track of fail attempts

                    //OnConfirmationFailure(error);
                    onConfirmSubmitFailure();
                },

            });

        }

        function onConfirmSubmitSuccess(result) {
            modalConfirm.style.display = "none";            
            sessionStorage.setItem("UserMessageText", "Success");
            sessionStorage.setItem("UserMessageColor","#228b22");
            window.location = 'Default';
        }
        function onConfirmSubmitFailure() {
            alert("Error: Please try again. If problem persits, contact admin!");
           
        }

        function viewDetails(id) {
            var dataValue = {
                "id": id
            };

            $.ajax({
                type: "get",
                url: "http://ahm43/connectivitywebapi/api/SelectReservationEntites",
                contentType: "application/json; charset=utf-8",
                data: dataValue,
                success: function (result) {                  
                    onViewDetailsSuccess(result);
                },
                error: function (xhr, status, error) {                  
                    onViewDetailsFailure();
                },

            });
        }
        function onViewDetailsSuccess(result) {

            let item = document.getElementById('viewItem');
            item.innerHTML = result[0].Name;

            let sdt = document.getElementById('viewStart');
            sdt.innerHTML = getMyFormatDate(new Date(result[0].Start_DateTime));

            let edt = document.getElementById('viewEnd');
            edt.innerHTML = getMyFormatDate(new Date(result[0].End_DateTime));

            let name = document.getElementById('viewName');
            name.innerHTML = result[0].Emp_Name;

            let reason = document.getElementById('viewReason');
            reason.innerHTML = result[0].Comment;


            modalViewDetail.style.display = 'block';
        }
        function onViewDetailsFailure() {

        }
        function getMyFormatDate(date) {
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            var d = date;
            var hours = d.getHours();
            var ampm = hours >= 12 ? 'PM' : 'AM';
            return months[d.getMonth()] + ' ' + d.getDate() + " " + d.getFullYear() + ' ' + hours + ':' + d.getMinutes() + ' ' + ampm;
        }
    </script>
    <script>

        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                plugins: ['dayGrid', 'timeGrid', 'list', 'interaction'],
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                },
                defaultDate: formatDate(new Date()),               
                eventLimit: true, // allow "more" link when too many events
                eventSources: [
                    {
                        url: 'http://ahm43/connectivitywebapi/api/SelectReservationEntites?',
                       
                        allDayDefault: false,
                    }

                ]
            });

            calendar.render();
        });

        function formatDate(date) {
            
            var day = date.getDate();
            var monthIndex = date.getMonth() + 1;
            var year = date.getFullYear();

            return year + '-' + monthIndex + '-' + day;
        }

</script>
</asp:Content>