var treeData = [
    {
        "UID": "1",
        "Name": "项目范围规划",
        "Duration": 8,
        "Start": "2007-01-01T00:00:00",
        "Finish": "2007-01-10T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "2",
        "Name": "确定项目范围",
        "Duration": 1,
        "Start": "2007-01-01T00:00:00",
        "Finish": "2007-01-01T23:23:59",
        "PercentComplete": 30,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": "1"
    },
    {
        "UID": "3",
        "Name": "获得项目所需资金",
        "Duration": 2,
        "Start": "2007-01-02T00:00:00",
        "Finish": "2007-01-03T23:23:59",
        "PercentComplete": 60,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "2"
            }
        ],
        "ParentTaskUID": "1"
    },
    {
        "UID": "4",
        "Name": "定义预备资源",
        "Duration": 2,
        "Start": "2007-01-04T00:00:00",
        "Finish": "2007-01-05T23:23:59",
        "PercentComplete": 40,
        "Summary": 0,
        "Critical": 1,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "3"
            }
        ],
        "ParentTaskUID": "1"
    },
    {
        "UID": "5",
        "Name": "获得核心资源",
        "Duration": 2,
        "Start": "2007-01-08T00:00:00",
        "Finish": "2007-01-09T23:23:59",
        "PercentComplete": 90,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "4"
            }
        ],
        "ParentTaskUID": "1"
    },
    {
        "UID": "6",
        "Name": "完成项目范围规划",
        "Duration": 0,
        "Start": "2007-01-10T00:00:00",
        "Finish": "2007-01-10T00:00:00",
        "PercentComplete": 10,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "5"
            }
        ],
        "ParentTaskUID": "1"
    },
    {
        "UID": "7",
        "Name": "分析/软件需求",
        "Duration": 20,
        "Start": "2007-01-11T00:00:00",
        "Finish": "2007-02-07T00:00:00",
        "PercentComplete": 40,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "8",
        "Name": "行为需求分析",
        "Duration": 6,
        "Start": "2007-01-11T00:00:00",
        "Finish": "2007-01-18T23:23:59",
        "PercentComplete": 50,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "6"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "9",
        "Name": "起草初步的软件规范",
        "Duration": 4,
        "Start": "2007-01-19T00:00:00",
        "Finish": "2007-01-24T23:23:59",
        "PercentComplete": 70,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "8"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "10",
        "Name": "制定初步预算",
        "Duration": 3,
        "Start": "2007-01-25T00:00:00",
        "Finish": "2007-01-29T23:23:59",
        "PercentComplete": 30,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "9"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "11",
        "Name": "工作组共同审阅软件规范/预算",
        "Duration": 1,
        "Start": "2007-01-30T00:00:00",
        "Finish": "2007-01-30T23:23:59",
        "PercentComplete": 20,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "10"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "12",
        "Name": "根据反馈修改软件规范",
        "Duration": 1,
        "Start": "2007-01-31T00:00:00",
        "Finish": "2007-01-31T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "11"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "13",
        "Name": "制定交付期限",
        "Duration": 1,
        "Start": "2007-02-01T00:00:00",
        "Finish": "2007-02-01T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "12"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "14",
        "Name": "获得开展后续工作的批准(概念、期限和预算)",
        "Duration": 1,
        "Start": "2007-02-02T00:00:00",
        "Finish": "2007-02-02T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "13"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "15",
        "Name": "获得所需资源",
        "Duration": 2,
        "Start": "2007-02-05T00:00:00",
        "Finish": "2007-02-06T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "14"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "16",
        "Name": "完成分析工作",
        "Duration": 0,
        "Start": "2007-02-07T00:00:00",
        "Finish": "2007-02-07T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "15"
            }
        ],
        "ParentTaskUID": "7"
    },
    {
        "UID": "17",
        "Name": "设计",
        "Duration": 21,
        "Start": "2007-02-08T00:00:00",
        "Finish": "2007-03-08T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "18",
        "Name": "审阅初步的软件规范",
        "Duration": 3,
        "Start": "2007-02-08T00:00:00",
        "Finish": "2007-02-12T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "16"
            }
        ],
        "ParentTaskUID": "17"
    },
    {
        "UID": "19",
        "Name": "制定功能规范",
        "Duration": 6,
        "Start": "2007-02-13T00:00:00",
        "Finish": "2007-02-20T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "18"
            }
        ],
        "ParentTaskUID": "17"
    },
    {
        "UID": "20",
        "Name": "根据功能规范开发原型",
        "Duration": 5,
        "Start": "2007-02-21T00:00:00",
        "Finish": "2007-02-27T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "19"
            }
        ],
        "ParentTaskUID": "17"
    },
    {
        "UID": "21",
        "Name": "审阅功能规范",
        "Duration": 3,
        "Start": "2007-02-28T00:00:00",
        "Finish": "2007-03-02T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "20"
            }
        ],
        "ParentTaskUID": "17"
    },
    {
        "UID": "22",
        "Name": "根据反馈修改功能规范",
        "Duration": 2,
        "Start": "2007-03-05T00:00:00",
        "Finish": "2007-03-06T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "21"
            }
        ],
        "ParentTaskUID": "17"
    },
    {
        "UID": "23",
        "Name": "获得开展后续工作的批准",
        "Duration": 1,
        "Start": "2007-03-07T00:00:00",
        "Finish": "2007-03-07T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "22"
            }
        ],
        "ParentTaskUID": "17"
    },
    {
        "UID": "24",
        "Name": "完成设计工作",
        "Duration": 0,
        "Start": "2007-03-08T00:00:00",
        "Finish": "2007-03-08T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "23"
            }
        ],
        "ParentTaskUID": "17"
    },
    {
        "UID": "25",
        "Name": "开发",
        "Duration": 35,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-04-26T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "26",
        "Name": "审阅功能规范",
        "Duration": 1,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-03-09T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "24"
            }
        ],
        "ParentTaskUID": "25"
    },
    {
        "UID": "27",
        "Name": "确定模块化/分层设计参数",
        "Duration": 1,
        "Start": "2007-03-12T00:00:00",
        "Finish": "2007-03-12T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "26"
            }
        ],
        "ParentTaskUID": "25"
    },
    {
        "UID": "28",
        "Name": "分派任务给开发人员",
        "Duration": 1,
        "Start": "2007-03-13T00:00:00",
        "Finish": "2007-03-13T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "27"
            }
        ],
        "ParentTaskUID": "25"
    },
    {
        "UID": "29",
        "Name": "编写代码",
        "Duration": 15,
        "Start": "2007-03-14T00:00:00",
        "Finish": "2007-04-03T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "28"
            }
        ],
        "ParentTaskUID": "25"
    },
    {
        "UID": "30",
        "Name": "开发人员测试(初步调试)",
        "Duration": 16,
        "Start": "2007-04-04T00:00:00",
        "Finish": "2007-04-25T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "29"
            }
        ],
        "ParentTaskUID": "25"
    },
    {
        "UID": "31",
        "Name": "完成开发工作",
        "Duration": 0,
        "Start": "2007-04-26T00:00:00",
        "Finish": "2007-04-26T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "30"
            }
        ],
        "ParentTaskUID": "25"
    },
    {
        "UID": "32",
        "Name": "测试",
        "Duration": 73,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-06-19T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "33",
        "Name": "根据产品规范制定单元测试计划",
        "Duration": 4,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-03-14T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "24"
            }
        ],
        "ParentTaskUID": "32"
    },
    {
        "UID": "34",
        "Name": "根据产品规范制定整体测试计划",
        "Duration": 4,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-03-14T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "24"
            }
        ],
        "ParentTaskUID": "32"
    },
    {
        "UID": "35",
        "Name": "单元测试",
        "Duration": 21,
        "Start": "2007-04-27T00:00:00",
        "Finish": "2007-05-25T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": "32"
    },
    {
        "UID": "36",
        "Name": "审阅模块化代码",
        "Duration": 6,
        "Start": "2007-04-27T00:00:00",
        "Finish": "2007-05-04T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "33"
            },
            {
                "Type": 1,
                "PredecessorUID": "31"
            }
        ],
        "ParentTaskUID": "35"
    },
    {
        "UID": "37",
        "Name": "测试组件模块是否符合产品规范",
        "Duration": 3,
        "Start": "2007-05-07T00:00:00",
        "Finish": "2007-05-09T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "31"
            },
            {
                "Type": 1,
                "PredecessorUID": "36"
            }
        ],
        "ParentTaskUID": "35"
    },
    {
        "UID": "38",
        "Name": "找出不符合产品规范的异常情况",
        "Duration": 4,
        "Start": "2007-05-10T00:00:00",
        "Finish": "2007-05-15T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "37"
            }
        ],
        "ParentTaskUID": "35"
    },
    {
        "UID": "39",
        "Name": "修改代码",
        "Duration": 4,
        "Start": "2007-05-16T00:00:00",
        "Finish": "2007-05-21T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "38"
            }
        ],
        "ParentTaskUID": "35"
    },
    {
        "UID": "40",
        "Name": "重新测试经过修改的代码",
        "Duration": 3,
        "Start": "2007-05-22T00:00:00",
        "Finish": "2007-05-24T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "39"
            }
        ],
        "ParentTaskUID": "35"
    },
    {
        "UID": "41",
        "Name": "完成单元测试",
        "Duration": 0,
        "Start": "2007-05-25T00:00:00",
        "Finish": "2007-05-25T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "40"
            }
        ],
        "ParentTaskUID": "35"
    },
    {
        "UID": "42",
        "Name": "整体测试",
        "Duration": 17,
        "Start": "2007-05-28T00:00:00",
        "Finish": "2007-06-19T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": "32"
    },
    {
        "UID": "43",
        "Name": "测试模块集成情况",
        "Duration": 6,
        "Start": "2007-05-28T00:00:00",
        "Finish": "2007-06-04T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "41"
            }
        ],
        "ParentTaskUID": "42"
    },
    {
        "UID": "44",
        "Name": "找出不符合规范的异常情况",
        "Duration": 3,
        "Start": "2007-06-05T00:00:00",
        "Finish": "2007-06-07T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "43"
            }
        ],
        "ParentTaskUID": "42"
    },
    {
        "UID": "45",
        "Name": "修改代码",
        "Duration": 4,
        "Start": "2007-06-08T00:00:00",
        "Finish": "2007-06-13T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "44"
            }
        ],
        "ParentTaskUID": "42"
    },
    {
        "UID": "46",
        "Name": "重新测试经过修改的代码",
        "Duration": 3,
        "Start": "2007-06-14T00:00:00",
        "Finish": "2007-06-18T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "45"
            }
        ],
        "ParentTaskUID": "42"
    },
    {
        "UID": "47",
        "Name": "完成整体测试",
        "Duration": 0,
        "Start": "2007-06-19T00:00:00",
        "Finish": "2007-06-19T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "46"
            }
        ],
        "ParentTaskUID": "42"
    },
    {
        "UID": "48",
        "Name": "培训",
        "Duration": 64,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-06-06T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "49",
        "Name": "制定针对最终用户的培训规范",
        "Duration": 3,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-03-13T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "24"
            }
        ],
        "ParentTaskUID": "48"
    },
    {
        "UID": "50",
        "Name": "制定针对产品技术支持人员的培训规范",
        "Duration": 3,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-03-13T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "24"
            }
        ],
        "ParentTaskUID": "48"
    },
    {
        "UID": "51",
        "Name": "确定培训方法(基于计算机的培训、教室授课等)",
        "Duration": 2,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-03-12T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "24"
            }
        ],
        "ParentTaskUID": "48"
    },
    {
        "UID": "52",
        "Name": "编写培训材料",
        "Duration": 16,
        "Start": "2007-04-27T00:00:00",
        "Finish": "2007-05-18T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "49"
            },
            {
                "Type": 1,
                "PredecessorUID": "31"
            },
            {
                "Type": 1,
                "PredecessorUID": "50"
            },
            {
                "Type": 1,
                "PredecessorUID": "51"
            }
        ],
        "ParentTaskUID": "48"
    },
    {
        "UID": "53",
        "Name": "研究培训材料的可用性",
        "Duration": 5,
        "Start": "2007-05-21T00:00:00",
        "Finish": "2007-05-25T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "52"
            }
        ],
        "ParentTaskUID": "48"
    },
    {
        "UID": "54",
        "Name": "对培训材料进行最后处理",
        "Duration": 4,
        "Start": "2007-05-28T00:00:00",
        "Finish": "2007-05-31T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "53"
            }
        ],
        "ParentTaskUID": "48"
    },
    {
        "UID": "55",
        "Name": "制定培训机制",
        "Duration": 3,
        "Start": "2007-06-01T00:00:00",
        "Finish": "2007-06-05T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "54"
            }
        ],
        "ParentTaskUID": "48"
    },
    {
        "UID": "56",
        "Name": "完成培训材料",
        "Duration": 0,
        "Start": "2007-06-06T00:00:00",
        "Finish": "2007-06-06T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "55"
            }
        ],
        "ParentTaskUID": "48"
    },
    {
        "UID": "57",
        "Name": "文档",
        "Duration": 42,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-05-07T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "58",
        "Name": "制定“帮助”规范",
        "Duration": 1,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-03-09T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "24"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "59",
        "Name": "开发“帮助”系统",
        "Duration": 16,
        "Start": "2007-04-04T00:00:00",
        "Finish": "2007-04-25T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "58"
            },
            {
                "Type": 1,
                "PredecessorUID": "29"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "60",
        "Name": "审阅“帮助”文档",
        "Duration": 4,
        "Start": "2007-04-26T00:00:00",
        "Finish": "2007-05-01T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "59"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "61",
        "Name": "根据反馈修改“帮助”文档",
        "Duration": 3,
        "Start": "2007-05-02T00:00:00",
        "Finish": "2007-05-04T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "60"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "62",
        "Name": "制定用户手册规范",
        "Duration": 2,
        "Start": "2007-03-09T00:00:00",
        "Finish": "2007-03-12T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "24"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "63",
        "Name": "编写用户手册",
        "Duration": 16,
        "Start": "2007-04-04T00:00:00",
        "Finish": "2007-04-25T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "62"
            },
            {
                "Type": 1,
                "PredecessorUID": "29"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "64",
        "Name": "审阅所有的用户文档",
        "Duration": 3,
        "Start": "2007-04-26T00:00:00",
        "Finish": "2007-04-30T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "63"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "65",
        "Name": "根据反馈修改用户文档",
        "Duration": 3,
        "Start": "2007-05-01T00:00:00",
        "Finish": "2007-05-03T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "64"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "66",
        "Name": "完成文档",
        "Duration": 0,
        "Start": "2007-05-07T00:00:00",
        "Finish": "2007-05-07T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "65"
            },
            {
                "Type": 1,
                "PredecessorUID": "61"
            }
        ],
        "ParentTaskUID": "57"
    },
    {
        "UID": "67",
        "Name": "试生产",
        "Duration": 105,
        "Start": "2007-02-08T00:00:00",
        "Finish": "2007-07-04T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "68",
        "Name": "确定测试群体",
        "Duration": 2,
        "Start": "2007-02-08T00:00:00",
        "Finish": "2007-02-09T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "16"
            }
        ],
        "ParentTaskUID": "67"
    },
    {
        "UID": "69",
        "Name": "确定软件分发机制",
        "Duration": 2,
        "Start": "2007-02-12T00:00:00",
        "Finish": "2007-02-13T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "68"
            }
        ],
        "ParentTaskUID": "67"
    },
    {
        "UID": "70",
        "Name": "安装/部署软件",
        "Duration": 2,
        "Start": "2007-06-20T00:00:00",
        "Finish": "2007-06-21T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "47"
            },
            {
                "Type": 1,
                "PredecessorUID": "69"
            },
            {
                "Type": 1,
                "PredecessorUID": "66"
            },
            {
                "Type": 1,
                "PredecessorUID": "56"
            }
        ],
        "ParentTaskUID": "67"
    },
    {
        "UID": "71",
        "Name": "获得用户反馈",
        "Duration": 6,
        "Start": "2007-06-22T00:00:00",
        "Finish": "2007-06-29T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "70"
            }
        ],
        "ParentTaskUID": "67"
    },
    {
        "UID": "72",
        "Name": "评估测试信息",
        "Duration": 2,
        "Start": "2007-07-02T00:00:00",
        "Finish": "2007-07-03T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "71"
            }
        ],
        "ParentTaskUID": "67"
    },
    {
        "UID": "73",
        "Name": "完成试生产工作",
        "Duration": 0,
        "Start": "2007-07-04T00:00:00",
        "Finish": "2007-07-04T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "72"
            }
        ],
        "ParentTaskUID": "67"
    },
    {
        "UID": "74",
        "Name": "部署",
        "Duration": 11,
        "Start": "2007-07-05T00:00:00",
        "Finish": "2007-07-19T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "75",
        "Name": "确定最终部署策略",
        "Duration": 2,
        "Start": "2007-07-05T00:00:00",
        "Finish": "2007-07-06T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "73"
            }
        ],
        "ParentTaskUID": "74"
    },
    {
        "UID": "76",
        "Name": "确定部署方法",
        "Duration": 2,
        "Start": "2007-07-09T00:00:00",
        "Finish": "2007-07-10T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "75"
            }
        ],
        "ParentTaskUID": "74"
    },
    {
        "UID": "77",
        "Name": "获得部署所需资源",
        "Duration": 2,
        "Start": "2007-07-11T00:00:00",
        "Finish": "2007-07-12T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "76"
            }
        ],
        "ParentTaskUID": "74"
    },
    {
        "UID": "78",
        "Name": "培训技术支持人员",
        "Duration": 2,
        "Start": "2007-07-13T00:00:00",
        "Finish": "2007-07-16T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "77"
            }
        ],
        "ParentTaskUID": "74"
    },
    {
        "UID": "79",
        "Name": "部署软件",
        "Duration": 2,
        "Start": "2007-07-17T00:00:00",
        "Finish": "2007-07-18T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "78"
            }
        ],
        "ParentTaskUID": "74"
    },
    {
        "UID": "80",
        "Name": "完成部署工作",
        "Duration": 0,
        "Start": "2007-07-19T00:00:00",
        "Finish": "2007-07-19T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "79"
            }
        ],
        "ParentTaskUID": "74"
    },
    {
        "UID": "81",
        "Name": "实施工作结束后的回顾",
        "Duration": 7,
        "Start": "2007-07-20T00:00:00",
        "Finish": "2007-07-30T00:00:00",
        "PercentComplete": 0,
        "Summary": 1,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [],
        "ParentTaskUID": -1
    },
    {
        "UID": "82",
        "Name": "将经验教训记录存档",
        "Duration": 2,
        "Start": "2007-07-20T00:00:00",
        "Finish": "2007-07-23T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "80"
            }
        ],
        "ParentTaskUID": "81"
    },
    {
        "UID": "83",
        "Name": "分发给工作组成员",
        "Duration": 2,
        "Start": "2007-07-24T00:00:00",
        "Finish": "2007-07-25T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "82"
            }
        ],
        "ParentTaskUID": "81"
    },
    {
        "UID": "84",
        "Name": "建立软件维护小组",
        "Duration": 2,
        "Start": "2007-07-26T00:00:00",
        "Finish": "2007-07-27T23:23:59",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 0,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "83"
            }
        ],
        "ParentTaskUID": "81"
    },
    {
        "UID": "85",
        "Name": "完成回顾",
        "Duration": 0,
        "Start": "2007-07-30T00:00:00",
        "Finish": "2007-07-30T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "84"
            }
        ],
        "ParentTaskUID": "81"
    },
    {
        "UID": "86",
        "Name": "软件开发模板结束",
        "Duration": 0,
        "Start": "2007-07-31T00:00:00",
        "Finish": "2007-07-31T00:00:00",
        "PercentComplete": 0,
        "Summary": 0,
        "Critical": 0,
        "Milestone": 1,
        "PredecessorLink": [
            {
                "Type": 1,
                "PredecessorUID": "85"
            }
        ],
        "ParentTaskUID": -1
    }
]