// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron and TIM Electron SDK
// Cloud Type Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMCloudDefUnit;

interface

type

  {
  ****************************************
  自定义消息类型 TTIMCustomElem
  ****************************************
  }

  TTIMCustomElem = record
    custom_elem_data: String;  //数据,支持二进制数据
    custom_elem_desc: String;  //自定义描述
    custom_elem_ext: String;   //后台推送对应的ext字段
    custom_elem_sound: String; //自定义声音
    elem_type: NativeInt; //元素类型
  end;

  {
  ****************************************
  群成员信息类型 TTIMGroupMemberInfo
  ****************************************
  }

  TTIMGroupMemberInfo = record
    group_member_info_custom_info: array of String;  //群成员自定义信息
    group_member_info_face_url: String;              //群成员头像
    group_member_info_group_id: String;              //群组 ID
    group_member_info_identifier: String;            //群组成员ID
    group_member_info_join_time: NativeInt;          //群组成员加入时间
    group_member_info_member_role: NativeInt;        //群组成员角色[TIMGroupMemberRole]
    group_member_info_msg_flag: NativeInt;           //成员接收消息的选项[TIMReceiveMessageOpt]
    group_member_info_msg_seq: NativeInt;            //消息序列号
    group_member_info_name_card: String;             //群成员名片
    group_member_info_nick_name: String;             //群昵称
    group_member_info_remark: String;                //群备注
    group_member_info_shutup_time: NativeInt;        //群成员禁言时间
  end;
  
  {
  ****************************************
  用户信息类型 TTIMUserProfile
  ****************************************
  }

  TTIMUserProfile = record
    user_profile_add_permission: NativeInt;           //用户加好友的选项
    user_profile_birthday: NativeInt;                 //生日
    user_profile_custom_string_array: array of String;//自定义资料
    user_profile_face_url: String;                    //用户头像URL
    user_profile_gender: NativeInt;                   //性别
    user_profile_identifier: String;                  //用户ID
    user_profile_language: NativeInt;                 //语言
    user_profile_level: NativeInt;                    //等级
    user_profile_location: String;                    //用户位置信息
    user_profile_nick_name: String;                   //用户的昵称
    user_profile_role: NativeInt;                     //角色
    user_profile_self_signature: String;              //用户个人签名
  end;

  {
  ****************************************
  消息类型 TTIMMessage
  ****************************************
  }

  TTIMMessage = record
    message_client_time: NativeUInt;                           //客户端时间
    message_cloud_custom_str: String;                          //消息自定义数据（云端保存，会发送到对端，程序卸载重装后还能拉取到）
    message_conv_id: String;                                   //消息所属会话ID
    message_conv_type: NativeInt;                              //消息所属会话类型 
    message_custom_int: NativeInt;                             //自定义整数值字段（本地保存，不会发送到对端，程序卸载重装后失效）
    message_custom_str: String;                                //自定义数据字段（本地保存，不会发送到对端，程序卸载重装后失效）
    message_elem_array: array of TTIMCustomElem;               //消息内元素列表
    message_excluded_from_last_message: Boolean;               //是否作为会话的 lasgMessage，true - 不作为，false - 作为
    message_has_sent_receipt: Boolean;                         //对于群消息接收者，是否发送了群消息已读回执
    message_is_excluded_from_unread_count: Boolean;            //消息是否不计入未读计数：默认为 NO，表明需要计入未读计数，设置为 YES，表明不需要计入未读计数
    message_is_from_self: Boolean;                             //消息是否来自自己
    message_is_online_msg: Boolean;                            //消息是否是在线消息，false表示普通消息,true表示阅后即焚消息，默认为false
    message_is_peer_read: Boolean;                             //消息是否被会话对方已读
    message_is_read: Boolean;                                  //消息是否已读
    message_msg_id: String;                                    //消息的唯一标识
    message_need_read_receipt: Boolean;                        //群消息是否需要已读回执
    message_platform: NativeInt;                               //发送消息的平台
    message_priority: NativeInt;                               //消息优先级
    message_rand: NativeInt;                                   //消息的随机码
    message_sender: String;                                    //消息的发送者
    message_sender_group_member_info: TTIMGroupMemberInfo;     //消息发送者在群里面的信息，只有在群会话有效。目前仅能获取字段 kTIMGroupMemberInfoIdentifier、kTIMGroupMemberInfoNameCard 其他的字段建议通过 TIMGroupGetMemberInfoList 接口获取
    message_sender_profile: TTIMUserProfile;                   //消息的发送者的用户资料
    message_seq: NativeInt;                                    //消息序列
    message_server_time: NativeUInt;                           //服务端时间
    message_status: NativeInt;                                 //消息当前状态
    message_unique_id: NativeUInt;                             //消息的唯一标识，推荐使用 kTIMMsgMsgId
    msg_receipt_read_count: NativeInt;                         //群消息已读回执数
    msg_receipt_unread_count: NativeUInt;                      //群消息未读回执数
  end;
  
  {
  ****************************************
  会话信息类型 TTIMConvInfo
  ****************************************
  }

  TTIMConvInfo = record
    conv_active_time: NativeUInt;  //会话的激活时间，（注意）超过19位的整型值在JS中会出现精度丢失的问题，如果需要使用此字段需要转换成字符串
    conv_id: String;               //会话ID
    conv_is_has_draft: Boolean;    //会话是否有草稿
    conv_is_has_lastmsg: Boolean;  //会话是否有最后一条消息
    conv_is_pinned: Boolean;       //是否置顶
    conv_last_msg: TTIMMessage;    //会话最后一条消息
    conv_recv_opt: NativeInt;      //消息接收选项
    conv_show_name: String;        //获取会话展示名称，其展示优先级如下：1、群组，群名称 C2C; 2、对方好友备注->对方昵称->对方的 userID
    conv_type: NativeInt;          //会话类型
    conv_unread_num: NativeInt;    //会话未读计数
  end;
  
  {
  ****************************************
  会话信息数组类型 TTIMConvInfoArray
  ****************************************
  }

  TTIMConvInfoArray = array of TTIMConvInfo;
const
  {
  ****************************************
  网络连接事件类型 TIMNetworkStatus
  *****************************************
  }

  kTIMConnected = 0;       // 已连接
  kTIMDisconnected = 1;    // 失去连接
  kTIMConnecting = 2;      // 正在连接
  kTIMConnectFailed = 3;   // 连接失败

  {
  ****************************************
  登陆状态 TIMLoginStatus
  *****************************************
  }

  kTIMLoginStatus_Logined = 1;     // 已登录
  kTIMLoginStatus_Logining = 2;    // 登录中
  kTIMLoginStatus_UnLogined = 3;   // 未登录
  kTIMLoginStatus_Logouting = 4;   // 登出中

  {
  ****************************************
  调用接口的返回值 TIMResult

  note: 若接口参数中有回调，只有当接口返回TIM_SUCC时，回调才会被调用
  *****************************************
  }

  TIM_SUCC = 0;          // 接口调用成功
  TIM_ERR_SDKUNINIT = -1; // 接口调用失败，ImSDK未初始化
  TIM_ERR_NOTLOGIN = -2; // 接口调用失败，用户未登录
  TIM_ERR_JSON = -3;     // 接口调用失败，错误的Json格式或Json Key
  TIM_ERR_PARAM = -4;    // 接口调用失败，参数错误
  TIM_ERR_CONV = -5;     // 接口调用失败，无效的会话
  TIM_ERR_GROUP = -6;    // 接口调用失败，无效的群组

  {
  ****************************************
  会话事件类型 TIMConvEvent
  ****************************************
  }

  kTIMConvEvent_Add = 0;    // 会话新增,例如收到一条新消息,产生一个新的会话是事件触发
  kTIMConvEvent_Del = 1;    // 会话删除,例如自己删除某会话时会触发
  kTIMConvEvent_Update = 2; // 会话更新,会话内消息的未读计数变化和收到新消息时触发
  kTIMConvEvent_Start = 3;  // 会话开始
  kTIMConvEvent_Finish = 4; // 会话结束

  {
  ****************************************
  会话类型 TIMConvType
  ****************************************
  }

  kTIMConv_Invalid = 0; // 无效会话
  kTIMConv_C2C = 1;     // 个人会话
  kTIMConv_Group = 2;   // 群组会话
  kTIMConv_System = 3;  // 系统会话

implementation

end.