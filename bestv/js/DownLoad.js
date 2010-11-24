function DownLoad(){}

DownLoad.prototype.Info = new Info();
DownLoad.prototype.Ctrl = new Ctrl();

function Info()
{	
	/*
	*����е�����֧����f 
	*1֧������ 0��֧������
	*/
	this.checkStatus = function()	
	{
		var status = iPanel.ioctlRead("Download_status");
		return status;
	}
	
	/*
	*��ȡ��ǰ���������ID
	*/
	this.getTaskID = function()
	{
		var taskID = iPanel.ioctlRead("Download_task_getcurrentid");
		return taskID;
	}
	
	/*
	*��ȡ�����������Ŀ��state����״̬
	*/
	this.getTaskNum = function(state)
	{
		var num = iPanel.ioctlRead("Download_task_list_count,"+state);
		return num;
	}
	
	/*
	*��ȡ����������ϸ��Ϣ id ����idֵ
	*/
	this.getTaskInfoById = function(id)
	{
		iPanel.debug("id::::"+id);
		var info = iPanel.ioctlRead("Download_task_info,"+id);  
		eval("info="+info);  
		iPanel.debug("info:::"+info);
		return info;
	}

	/*
	*��ȡ����������б?state����״̬��position��ʼ��ţ�count��ȡ��������ֵΪJSON��ʽ�ַ�
	*/
	this.getTaskListByState = function(state)
	{
		var taskList = new Array();
		var tmpList = new Array();
		var position = 0;
		var count = this.getTaskNum(state);
		var list = iPanel.ioctlRead("Download_task_list,"+position+","+count+","+state);

		eval("list=" + list);
		position += list.task_list_count;
		
		if(0 == taskList.length)
		{
			taskList = list.task_list;
		}
		else
		{
			taskList = taskList.concat(list.task_list);
		}
		
		if(taskList.length == count)
		{
			for (var i = 0;i < taskList.length;i++)
			{
				taskList[i].state = state;
			}
		}
		return taskList;
	}
	
	/*
	*����ָ��Ŀ¼����¼���ļ�����type�ļ���������൱��Ŀ¼�ĸ���
	*/
	this.getAchieveNum = function()
	{
		var type = 1;
		var num = iPanel.ioctlRead("Download_task_get_file_count,"+type);
		return num;
	}
	
	/*
	*��ȡָ��Ŀ¼���������ļ��б�
	*/
	this.getAchieveList = function()
	{
		var count = this.getAchieveNum();
		var type = 1;
		var position = 0;
		var achieveList = new Array();
		
		var list = iPanel.ioctlRead("Download_task_get_file_list ,"+position+","+count+","+type);
		eval("list="+list);
		position += achieveList.file_list_count;
		
		if(0 == achieveList)
		{
			achieveList = list.file_list;
		}
		else
		{
			achieveList = achieveList.concat(list.file_list);
		}

		for (var i = 0;i < count;i++)
		{
			achieveList[i].state = 0;
		}
		return achieveList;
	}
	
	/*
	*��ȡ�����ļ��ļ��б�
	*/
	this.getSearchList = function(condition)
	{
		iPanel.ioctlWrite("Download_task_get_file_setfilter",condition);
		var count = this.getAchieveNum();
		var type = 1;
		var position = 0;
		var searchList = new Array();
		
		var list = iPanel.ioctlRead("Download_task_get_file_list ,"+position+","+count+","+type);
		eval("list="+list);
		position += searchList.file_list_count;
		
		if(0 == searchList)
		{
			searchList = list.file_list;
		}
		else
		{
			searchList = searchList.concat(list.file_list);
		}

		for (var i = 0;i < count;i++)
		{
			searchList[i].state = 0;
		}
		return searchList;
	}
	
	/*
	*��ȡ����Ӳ�̿ռ�
	*/
	this.getDoSpace = function()
	{
		var space = iPanel.ioctlRead("Download_task_getdisk_avail");
		return space;
	}
	
	/*
	*��ȡ������ϸ��Ϣ
	*/
	this.getTaskInfo = function(taskID)
	{
		var Metadata = iPanel.ioctlRead("Download_task_info,"+TaskID);
		return Metadata;
	}

	/*
	*�ο��Ƿ�����Ӧ��contentId�����������б���
	* param:contentId 
	* return boolean
	* 7 ����7��״̬��������ɡ�����ʧ�ܡ��������ء�����
	*/
	this.isTaskExist = function (vodId)
	{
		iPanel.debug("in DownLoan.js isTaskExist()**************vodId:"+vodId);
		for (var state = 0; state < 7; state++)
		{
			var taskList = DownLoad.Info.getTaskListByState(state);
			iPanel.debug("in DownLoan.js taskList()**************:"+taskList);
			for(var j = 0;j < taskList.length;j++)
			{
				if(taskList[j].ContentID == vodId)
				{
					
					return true;
				}
			}
		}
		return false;
	}
	/*
	*��ȡ��¼���ļ����
	*/
	this.getFileType = function()
	{
	}
	
}

function Ctrl()
{
	/*
	*������������
	*@param playUrl ����url : "rtsp://....../aa.ts?...."
	*		vodId �ļ���ʶID
	* 		vodName �������
	*/
	this.createDownLoad = function(vodId,vodName,playUrl,mediaId)
	{
		var filetype = 1;	//�ļ����1
		var DRMtype = "0";
		var httpUrl = url;
		var tempLastIndex = playUrl.lastIndexOf("?");
		tempLastIndex =-1;
		if(-1 == tempLastIndex)
		{
			var tempUrl = playUrl.substring(playUrl.indexOf("rtsp://"));
		}
		else
		{
			var tempUrl = playUrl.substring(playUrl.indexOf("rtsp://"), playUrl.lastIndexOf("?"));
		}
		
		var fileName = tempUrl.substring(tempUrl.lastIndexOf("/") + 1, tempUrl.lastIndexOf("."));
		var url = tempUrl.replace("rtsp://","http://");
		var fileType = 1;	//�ļ����1
		var DRMType = "0";
		var path = playUrl.substring(playUrl.indexOf("://")+3,playUrl.length);
	    path = path.substring(path.indexOf("/")+1,path.lastIndexOf("/"));
		
		iPanel.ioctlWrite("playUrl===" , playUrl);
		iPanel.ioctlWrite("tempUrl===" ,tempUrl);
		iPanel.ioctlWrite("fileName===" , fileName);
		iPanel.ioctlWrite("url===" ,url);
		iPanel.ioctlWrite("path===", path);
			
		var downLoadUrl = path+"^"+fileName+"^"+vodId+"^"+vodName+"^"+fileType+"^"+DRMType+"^"+mediaId+"^"+url;
		iPanel.debug("downLoadUrl===" + downLoadUrl);
		iPanel.ioctlWrite("Download_record",downLoadUrl);

	}
	
	/*
	*	ͨ��vodId��ȡ����id
	*/
	this.getTaskIdByVodId = function(vodId)
	{
		var list = iPanel.ioctlRead("Download_task_get_exist,"+vodId);
		eval("list="+list);  
		var taskId = list.TaskID; 
		return taskId;
	}




	/*
	*�жϻ������״̬
	*/
	this.downLoadState = function(vodId)
	{
		var list = iPanel.ioctlRead("Download_task_get_exist,"+vodId);
		eval("list="+list);
		var state = list.state;
		return state;
	}
	
	/*
	*ֹͣ��������
	*/
	this.stopDownLoad = function(taskID)
	{
		iPanel.debug("in DownLoan.js stopDownLoad()******************************");
		iPanel.ioctlWrite("Download_task_stop",taskID);
	}
	
	/*
	*�ָ���������
	*/
	this.resumeDownLoad = function(taskID)
	{
		iPanel.debug("in DownLoan.js resumeDownLoad()******************************");
		iPanel.ioctlWrite("Download_task_resume",taskID);
	}
	/*
	*�ö�����
	*/
	this.moveTaskTop = function(taskID)
	{
		iPanel.debug("in DownLoan.js moveTaskTop()******************************");
		iPanel.ioctlWrite("Download_Manager_MoveTaskTop",taskID);
	}
	/*
	* ɾ���������� 
	*/
	this.deleteTask = function(taskID)
	{
		iPanel.debug("in DownLoan.js deleteTask()******************************");
		iPanel.ioctlWrite("Download_task_delete",taskID);
	}
	
	/*
	*ɾ���ļ�
	*/
	this.deleteFile = function(taskID)
	{
		iPanel.debug("in DownLoan.js deleteFile()******************************");
		iPanel.ioctlWrite("Download_file_delete",taskID);
	}
	
	/*
	*ɾ���ļ���  param:state
	*/
	this.deleteDir = function(type)
	{
		iPanel.debug("in DownLoan.js deleteDir()******************************");
		iPanel.ioctlWrite("Download_dir_delete",type);
	}

	/*
	*���ҳ��״̬λ��ɾ��
	* param:ҳ��Ľ���λ��
	*/
	this.deleteByState = function(state_focus)
	{
		if (0 == state_focus )//�Ѿ���������ƶ������ļ���
		{
			this.deleteTaskByState(0);
		}
		else if (1 == state_focus )//δ������ɵ��ļ���
		{
			this.deleteTaskByState(1);
			this.deleteTaskByState(2);
			this.deleteTaskByState(3);
			this.deleteTaskByState(5);			
		}
		else if (2 == state_focus)//���ط�������ƶ������ļ���
		{
			this.deleteTaskByState(4);
		}
		else if(3 == state_focus)//ִ��ɾ������ƶ������ļ���
		{
			this.deleteTaskByState(6);
		}
	}
	
	/*
	*	���״̬λ��ɾ������ �ͱ����ļ�
	*/
	this.deleteTaskByState = function(state)
	{
		var taskList;
		taskList = DownLoad.Info.getTaskListByState(state);//ɾ������	
		for(var i = 0;i < taskList.length;i++)
		{
			this.deleteTask(taskList[i].TaskID);			
		}
	}
}


