<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리 - [수정구현]</title>
<%@ include file="./JEasyUICommon.jsp" %>
	<script type="text/javascript">
	//여기가 전변 자리이다.
	//전역변수는 그 페이지내에서 계속 유지 되므로 업무 프로세스가 새로 시작할 땐 처음값으로 반드시 초기화 
		var g_address =''; //사용자가 선택한 주소정보 담기
		var g_cnt 	  = 0; //수정시 한 건만 선택되었는지 체크함.
		var g_empno   = 0;
		//등록 화면 열기
		function empINS(){
			//insert here
			$("#dlg_ins").dialog('open');
		}//end of empIns
		//수정 화면 열기
		function empUPD(){
			//insert here
			//여기서 if만약에 cnt가 1보다크니해줘야한다 수정을못하게
			if(g_cnt>1){
				$.messager.alert('Info','한번에 한건만 수정할 수 있습니다.');
				empList();
				return;//return값을 쓰면mpUpd함수 탈출할수있다.
			}
			//수정할 사원을 선택하세요
			if(g_empno==0){
				$.messager.alert('Info','수정할 사원을 선택하세요.');
				empList();
				return;//return값을 쓰면empUpd함수 탈출할수있다.
			}
			else {
				$.ajax({
					url:'jsonEmpList2.jsp?empno='+g_empno
					,success:function(data){
						//g_empno가 선택이 됐는지 써야함
						//numberobx가있다 표준으로는 <input type="text" 이자리에 $("아이디")있어햔다.
						//numberbox(이벤트면 {function을 생각해야함. var setvalue = new function(7566){ }}처리 ) 이거대신 직접 함수처리 할 수 있다. setvalue 여기서 제공해주는 함수이름
						var result = JSON.stringify(data);
							alert(result);
						var arr    = JSON.parse(result);//배열임
						alert(arr);
						for(var i=0;i<arr.length;i++) {
						//그래서 .numberobx('setValue',arr[i].EMPNO); (함수,파라미터) 파라미터가 없으면 읽기모드가 안된다?? 없으면 파라미터(값) 안써도된다. 
							$("#u_empno").numberbox('setValue',arr[i].EMPNO);
							$("#u_ename").textbox('setValue',arr[i].ENAME);
							$("#u_job").textbox('setValue',arr[i].JOB);
							$("#u_hiredate").textbox('setValue',arr[i].HIREDATE);
							$("#u_mgr").numberbox('setValue',arr[i].MGR);
							$("#u_sal").numberbox('setValue',arr[i].SAL);
							$("#u_comm").numberbox('setValue',arr[i].COMM);
							$("#u_deptno").combobox('setValue',arr[i].DEPTNO);
						}
					}		
				});
			}
			$("#dlg_upd").dialog('open');
		}
		function empnoSearch(){
			//alert("empnoSearch 호출");
			var s_empno = $("#s_empno").val();//input박스 val이 
			$("#dg_emp").datagrid({
				url:'jsonEmpList2.jsp?empno'+s_empno
			});
		}
		function empList(){
			//조회될때 마다 새로 업무가 시작되도록 전역변수 초기화 해줄것
			g_cnt = 0;
		    $("#dg_emp").datagrid({
				url:"jsonEmpList2.jsp"
			   ,onLoadSuccess: function(data){
				    var result = JSON.stringify(data);
					alert("새로고침 처리 성공 : "+data+","+result);
				}			   
		   });
		}//end of empList	
		/////////////////// DataGrid에 직접 수정 모드 추가하기 시작 ////////////////////
		function getRowIndex(target){
		    var tr = $(target).closest('tr.datagrid-row');
		    return parseInt(tr.attr('datagrid-row-index'));
		}
		function editrow(target){
		    $('#dg_emp').datagrid('beginEdit', getRowIndex(target));
		}
		function deleterow(target){
		    $.messager.confirm('Confirm','Are you sure?',function(r){
		        if (r){
		            $('#dg_emp').datagrid('deleteRow', getRowIndex(target));
		        }
		    });
		}
		function saverow(target){
		    $('#dg_emp').datagrid('endEdit', getRowIndex(target));
		}
		function cancelrow(target){
		    $('#dg_emp').datagrid('cancelEdit', getRowIndex(target));
		}		
		/////////////////// DataGrid에 직접 수정 모드 추가하기  끝  ////////////////////
       function zipcode_search(){
          var dong = $("#dong").val();
          alert(dong);
          if(dong == null || dong.length<1){
             alert("동을 입력하세요.");
             return; //여기서는 함수의 영역을 빠져나감.
          }else{
             $("#dg_zipcode").datagrid({
                url:'jsonZipcodeList3.jsp?dong='+dong
              });
          }
       }
		//사원정보 등록 처리
		function emp_ins() {
			//alert("저장호출")
			//화면에서 입력받은 값은 http프로토콜을 이용해서  서버쪽으로 전송 되는데 이때 유니코드로 변환
			//되어 전달함
			//해결 방법 -server.xml문서에 포트번호 설정 위치(63번라인) URIEncoding = "UTF-8"
			//단get방식에만 적용됨 . post방식일때는 java코드를 활용하여 별도 처리 
			$("#f_ins").attr("method","get");
			$("#f_ins").attr("action","empInsert2.jsp");
			$("#f_ins").submit();
		}
		//사원정보 수정처리
		function emp_upd() {
			$("#f_upd").attr("method","get");//method가 get방식인지 post방식인지 정해주는 속성이다. 
			$("#f_upd").attr("action","empUpdate.jsp");
			$("#f_upd").submit();
		}
		//사원정보 삭제처리
		function emp_del() {
			var empnos = [];
			var rows = $('#dg_emp').datagrid('getSelections');
			for(var i=0; i<rows.length; i++){
			    empnos.push(rows[i].EMPNO);
			}
			//alert(empnos.join(','));
			pempno = empnos.join(',');
			$.messager.progress();//막대기 바 0%~100%
			if(empnos.length>0){
				location.href="empDelete.jsp?empno="+pempno
			}
			$("#dg_emp").datagrid('clearSelections');
		}
	</script>
</head>
<body>
<!--============= 검색 조건 추가하기  시작 ===============-->
<div id="tbar_emp">
	<form id="f_search">
		<table>
			<tr>
				<td width="190px">
					<label width="80px">사원번호</label>
					<input id="s_empno" name="s_empno" class="easyui-searchbox" data-options="prompt:'사원번호', searcher:empnoSearch" style="width:110px">
				</td>
			</tr>
			<tr>
				<td>
        		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="empList()">사원조회</a>
        		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-man" plain="true" onclick="empINS()">사원등록</a>
        		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="empUPD()">사원수정</a>
        		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="emp_del()">사원삭제</a>				
				</td>
			</tr>
		</table>
	</form>
</div>	
<!--============= 검색 조건 추가하기   끝   ===============-->
    <table id="dg_emp"></table>
   <div class="easyui-pagination" style="border:1px solid #ccc;"
        data-options="
            total: 2000,
            pageSize: 5,
            pageList:[2,3,5,10],
            onSelectPage: function(pageNumber, pageSize){
                $('#content').panel('refresh', 'show_content.php?page='+pageNumber);
            }">
</div>
	<script type="text/javascript">
		$(document).ready(function(){
			//$('#empno').textbox("labelPosition","top");
			/* 동이름 입력 후 엔터 쳤을때 처리하기*/
			var t = $('#dong');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){
					$("#dg_zipcode").datagrid({
		                url:'jsonZipcodeList3.jsp?dong='+$(this).val()
		               ,singleSelect:true
		               //선택한 로우의 우편번호와 주소 정보 읽어서 변수에 담기 처리
		               //여기서 ROW는 사용자가 선택한 로우의 정보를 가짐.
		               ,onSelect:function(index,row){
						   //아래에서 선택된 로우인지는 어떻게 아는 걸까?
						   //alert(row.ADDRESS);
						   g_address = row.ADDRESS;//필드명은 mybatis를 사용했으니까 꼭 대문자
					   },onDblClickCell:function(index,field, value){
						   if("ZIPCODE"==field){//너 우편번호 셀(컬럼)을 선택한거니?
							//더블클릭이벤트 핸들러를 셀을 선택했으니까 세번째 파라미터의 value는
							//사용자가 선택한 로우에 그 셀에 값을 가짐.
							   $("#zipcode").textbox('setValue',value);
							   $("#mem_addr").textbox('setValue',g_address);
							   $("#dg_zipcode").datagrid("clearSelections");
							   $("#dlg_zipcode").dialog('close');
						   }
					   }
		              });
				}
			});
			/* 우편번호 찾기 버튼 */
			      $("#dlg_zipcode").dialog({
             title:"우편번호 검색기"
             ,width:500
             ,height: 550
             ,closed:true
          });
          $("#dg_zipcode").datagrid({
             title:'우편번호 찾기 검색 결과'
             ,columns:[[
                 {field:'ZIPCODE', title:'우편번호', width:100, align:'center'}
                ,{field:'ADDRESS', title:'주소', width:400, align:'left'}
             ]]
          });
			$('#btn_zipcode').linkbutton({
				onClick:function(){
					//alert('우편번호 찾기 버튼 클릭');
					$("#dlg_zipcode").dialog({
						closed:false
					   ,title: '우편번호 검색기'
					});
				}
			});
			$('#dlg_upd').dialog({
				closed:true
			});
			$('#pp_emp').pagination({
				pageList: [2,3,5,10]
				,pageSize:5
			});
			$('#dg_emp').datagrid({
				toolbar:'#tbar_emp'
				//,singleSelect :true
			   ,width: '1100'
			   ,title:'사원관리 - 자바스크립트 만으로 구성하기'
			   ,columns:[[
			        {field:'CK', checkbox:true ,width:50,align:'center'}
			       ,{field:'EMPNO',title:'사원번호',width:90,align:'center', editor:'numberbox'}
			       ,{field:'ENAME',title:'사원명',width:120,align:'center', editor:'text'}
			       ,{field:'JOB',title:'JOB',width:130,align:'center', editor:'text'}
			       ,{field:'HIREDATE',title:'입사일자',width:150,align:'center', editor:'text'}
			       ,{field:'MGR',title:'MGR',width:90,align:'center', editor:'numberbox', hidden:'true'}
			       ,{field:'SAL',title:'급여',width:110,align:'center', editor:'numberbox'}
			       ,{field:'COMM',title:'인센티브',width:100,align:'center', editor:'numberbox'}
			       ,{field:'DEPTNO',title:'부서번호',width:150,align:'center'
			    	  ,editor:{
			    		 type:'combobox'
			    		,options:{
						   valueField:'DEPTNO'//실제 서버에 넘어가는 필드
						  ,textField:'DNAME' //화면에 출력되는 필드
						  ,url:'./jsonDeptList.jsp'
						  ,required:true
			    		}////////end of options
			    	  }//////////end of editor
			        }
			       ,{field:'action',title:'Action',width:100,align:'center',
		                formatter:function(value,row,index){
		                    if (row.editing){
		                        var s = '<a href="javascript:void(0)" onclick="saverow(this)">Save</a> ';
		                        var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">Cancel</a>';
		                        return s+c;// '안녕'||'내일봐'
		                    } else {
		                        var e = '<a href="javascript:void(0)" onclick="editrow(this)">Edit</a> ';
		                        var d = '<a href="javascript:void(0)" onclick="deleterow(this)">Delete</a>';
		                        return e+d;
		                    }
		                }
		            }
			    ]]
			,
	        onEndEdit:function(index,row){
	            var ed = $(this).datagrid('getEditor', {
	                index: index,
	                field: 'productid'
	            });
	            row.productname = $(ed.target).combobox('getText');
	        },
	        onBeforeEdit:function(index,row){
	            row.editing = true;
	            $(this).datagrid('refreshRow', index);
	        },
	        onAfterEdit:function(index,row){
	            row.editing = false;
	            $(this).datagrid('refreshRow', index);
	        },
	        onCancelEdit:function(index,row){
	            row.editing = false;
	            $(this).datagrid('refreshRow', index);
	        }			
	        ,onClickRow:function(index,row) {
	        	//alert("선택했네==>" +index+", "+row.EMPNO); 
	        	g_cnt++;
	        	if(g_cnt == 1){
	        		g_empno= row.EMPNO;
	        	}
	        }
			});///////////////////end of datagrid			
		});///////////////////////end of ready
	</script>
	<!--====================== 우편번호 찾기 시작 =======================-->
	<div id="dlg_zipcode" style="width:100%; max-width:600px; padding:30px 30px;">
		<input class="easyui-textbox" id="dong" name="dong" labelPosition="top" data-options="prompt:'동이름이나 주소 정보 입력...'" style="width:210px;">
		<a id="btn_search" class="easyui-linkbutton" href="javascript:zipcode_search();" data-options="iconCls:'icon-search'">찾기</a>
		<div style="margin-bottom:10px;"></div>
		<table id="dg_zipcode"></table>
	</div>
	<!--====================== 우편번호 찾기  끝   =======================-->
	<!--====================== 사원등록 시작 =======================-->
	<div id="dlg_ins" data-options="closed:true, title:'사원정보 입력',footer:'#d_ins', modal:'true'" class="easyui-dialog" style="width:100%;max-width:480px;padding:30px 60px">
		<form id="f_ins"> 
<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="empno" name="empno" label="사원번호" data-options="prompt:'Enter a EmpNO'" style="width:150px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="ename" name="ename" label="사원명" data-options="prompt:'Enter a ENAME'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="job" name="job" label="JOB" data-options="prompt:'Enter a JOB'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mgr" name="mgr" label="MGR" data-options="prompt:'Enter a MGR'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="hiredate" name="hiredate" label="입사일자" data-options="prompt:'Enter a 입사일자'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="sal" name="sal" label="급여" data-options="prompt:'Enter a 급여'" style="width:250px">
			</div>			
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="comm" name="comm" label="인센티브"  data-options="prompt:'Enter a 인센티브'" style="width:250px">
			</div>			
			<div style="margin-bottom:10px">
			<input class="easyui-combobox" id="deptno" name="deptno" style="width:250px" label="부서번호"  
			data-options="prompt:'Enter a 부서번호' 
					,valueField: 'DEPTNO'
	        		,textField: 'DNAME'
			        ,url: 'jsonDeptList.jsp'
			        ,onSelect: function(rec){
			        }"
			>
			</div>			
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="zipcode" name="zipcode" label="우편번호"  data-options="prompt:'Enter a ZIPCODE'" style="width:160px">
			<a id="btn_zipcode" href="#" class="easyui-linkbutton">우편번호찾기</a>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_addr" name="mem_addr" label="주소"  data-options="prompt:'Enter a ADDRESS'" style="width:420px">
			</div>
		</form>
			<div id="d_ins" style="margin-bottom:10px">
				<a id="btn_save"  href="javascript:emp_ins()" class= "easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
				<a id="btn_close" href="javascript:$('#dlg_ins').dialog('close')" class= "easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
			</div>
	</div>
	</script>
	<!--====================== 사원등록   끝  =======================-->
	<!--====================== 사원수정 시작 =======================-->
	<div id="dlg_upd" data-options="closed:true, title:'사원정보 수정',footer:'#d_upd', modal:'true'" class="easyui-dialog" style="width:100%;max-width:480px;padding:30px 60px">
		<form id="f_upd">
		<div style="margin-bottom:10px">
				<input class="easyui-numberbox" id="u_empno" name="empno" label="사원번호" data-options="prompt:'Enter a EmpNO'" style="width:150px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="u_ename" name="ename" label="사원명" data-options="prompt:'Enter a ENAME'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_job" name="job" label="JOB" data-options="prompt:'Enter a JOB'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="u_hiredate" name="hiredate" label="입사일자" data-options="prompt:'Enter a 입사일자'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
				<input class="easyui-numberbox" id="u_sal" name="sal" label="급여" data-options="prompt:'Enter a 급여'" style="width:250px">
			</div>			
			<div style="margin-bottom:10px">
				<input class="easyui-numberbox" id="u_comm" name="comm" label="인센티브"  data-options="prompt:'Enter a 인센티브'" style="width:250px">
			</div>			
			<div style="margin-bottom:10px">
				<input class="easyui-combobox" id="u_deptno" name="deptno" style="width:250px" label="부서번호"  
					    data-options="prompt:'Enter a 부서번호' 
						,valueField: 'DEPTNO'
		        		,textField: 'DNAME'
				        ,url: 'jsonDeptList.jsp'
				        ,onSelect: function(rec){
				        }">
			</div>			
			<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="u_zipcode" name="zipcode" label="우편번호"  data-options="prompt:'Enter a ZIPCODE'" style="width:160px">
				<a id="btn_zipcode" href="#" class="easyui-linkbutton">우편번호찾기</a>
			</div>
				<div style="margin-bottom:10px">
				<input class="easyui-textbox" id="u_mem_addr" name="mem_addr" label="주소"  data-options="prompt:'Enter a ADDRESS'" style="width:420px">
			</div>
		</form>
			<div id="d_upd" style="margin-bottom:10px">
				<a id="btn_save"  href="javascript:emp_upd()" class= "easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
				<a id="btn_close" href="javascript:$('#dlg_upd').dialog('close')" class= "easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
			</div>
	</div>	
	<%
		//수정처리가 완료된거니? 
		String mode = request.getParameter("mode");
		if("update".equals(mode) || ("insert".equals(mode))){
			
	%>
	<script type="text/javascript">
		empList();
	</script>
	<%

		}
	%>
	<!--====================== 사원수정   끝  =======================-->
	<!--====================== 사원삭제 시작 =======================-->
	<div id="dlg_del" class="easyui-dialog" data-options="closed:true" style="width:100%;max-width:480px;padding:30px 60px">
		<form id="f_del">
		삭제
		</form>
	</div>		
	<!--====================== 사원삭제   끝  =======================-->
</body>
</html>





