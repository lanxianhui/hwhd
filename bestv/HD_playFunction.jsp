<script type="text/javascript">

var mp = new MediaPlayer();

var json;

var speed = 1;
var playStat = "play";
var audioIndex = 0;
var subtitleIndex = 0;
var playType = "vod";

function playByTime(beginTime)
{
    var type = 1;
    var speed = 1;
    mp.playFromStart();
    mp.playByTime(type, beginTime, speed);
}

function pause()
{
    mp.pause();
    playStat = "pause";
}

function fastForward()
{
    if (speed >= 32 || playStat == "fastrewind")
    {
        speed = 1;
        playStat = "play";
        mp.resume();
    }
    else
    {
        speed = speed * 2;
        playStat = "fastforward";
        //iPanel.debug("fastForward();speed="+speed);
        mp.fastForward(speed);
    }
}

function fastRewind()
{
    if (speed >= 32 || playStat == "fastforward")
    {
        speed = 1;
        playStat = "play";
        mp.resume();
    }
    else
    {
        speed = speed * 2;
        playStat = "fastrewind";
        mp.fastRewind(-speed);
    }
}

function resume()
{
    playStat = "play";
    mp.resume();
}
function setSpeed(s_speed)
{
    speed = s_speed;
    if (speed > 0)
    {
        mp.fastForward(speed);
    }
    else if (speed < 0)
    {
        mp.fastRewind(speed);
    }
    if (speed == 0)
    {
        mp.pause();
    }
}

function goEnd()
{
    speed = 1;
    playStat = "play";

    if (playType == "vod")
    {
        var mediaTime = mp.getMediaDuration();
        if (mediaTime >= 10)
        {
            playByTime(mediaTime - 10);
        }
        else
        {
            playByTime(mediaTime);
        }
    }
    else
    {
        mp.gotoEnd();
    }
}

function goBeginning()
{
    speed = 1;
    playStat = "play";
    mp.gotoStart();
}

function switchAudioChannel()
{
    mp.switchAudioChannel();
}

function switchAudioTrack()
{
    mp.switchAudioTrack();
}

function switchSubtitle()
{
    mp.switchSubtitle();
}

function stop()
{
    mp.stop();
}

function initMediaPlay()
{
    var instanceId = mp.getNativePlayerInstanceID();
    var playListFlag = 0;
    var videoDisplayMode = 1;
    var height = 0;
    var width = 0;
    var left = 0;
    var top = 0;
    var muteFlag = 0;
    var subtitleFlag = 0;
    var videoAlpha = 0;

    var cycleFlag = 0;
    var randomFlag = 0;
    var autoDelFlag = 0;
    var useNativeUIFlag = 1;
    mp.initMediaPlayer(instanceId, playListFlag, videoDisplayMode, height, width, left, top, muteFlag, useNativeUIFlag, subtitleFlag, videoAlpha, cycleFlag, randomFlag, autoDelFlag);

    mp.setNativeUIFlag(1);
    mp.setAudioVolumeUIFlag(1);
    mp.setAudioTrackUIFlag(1);
    mp.setMuteUIFlag(1);

}

function pauseOrPlay()
{
    speed = 1;
    if (playStat == "play")
    {
        pause();
    }
    else
    {
        resume();
    }
}

function setMuteFlag()
{
    setMuteUIFlag(0);
    var muteFlag = mp.getMuteFlag();
    if (muteFlag == 1)
    {
        mp.setMuteFlag(0);
    }
    if (muteFlag == 0)
    {
        mp.setMuteFlag(1);
    }
}

function destoryMP()
{
    mp.leaveChannel();
    mp.releaseMediaPlayer(mp.getNativePlayerInstanceID());
}

function playChannelPig(chanNum, left, top, width, height)
{
    playType = "tv";
    initChannelMedia();
    mp.setVideoDisplayMode(0);
    mp.setVideoDisplayArea(left, top, width, height);
    mp.refreshVideoDisplay();

    mp.joinChannel(chanNum);
}

function playChannel(chanNum)
{
    playType = "tv";
    initChannelMedia();
    mp.setVideoDisplayMode(1);
    //mp.setVideoDisplayArea(left,top,width,height);
    mp.refreshVideoDisplay();

    mp.joinChannel(chanNum);
}

function initChannelMedia()
{
    json = '[{mediaUrl:"",';
    json += 'mediaCode: "jsoncode1",';
    json += 'mediaType:1,';
    json += 'audioType:1,';
    json += 'videoType:1,';
    json += 'streamType:1,';
    json += 'drmType:1,';
    json += 'fingerPrint:0,';
    json += 'copyProtection:1,';
    json += 'allowTrickmode:0,';
    json += 'startTime:0,';
    json += 'endTime:100.3,';
    json += 'entryID:"jsonentry1"}]';
    initMediaPlay();
    mp.setSingleMedia(json);
    mp.setAllowTrickmodeFlag(0);

}


function playVodPig(vodUrl, left, top, width, height)
{
    playType = "vod";
    initVodMedia(vodUrl);
    mp.setVideoDisplayMode(0);
    mp.setVideoDisplayArea(left, top, width, height);
    mp.refreshVideoDisplay();
    mp.playFromStart();
}

function playVod(vodUrl)
{
    playType = "vod";
    initVodMedia(vodUrl);
    mp.setVideoDisplayMode(1);
    //mp.setVideoDisplayArea(left,top,width,height);
    mp.refreshVideoDisplay();
    mp.playFromStart();
}

function initVodMedia(vodUrl)
{
    json = '[{mediaUrl : "' + vodUrl + '",';
    json += 'mediaCode: "jsoncode1",';
    json += 'mediaType:1,';
    json += 'audioType:1,';
    json += 'videoType:1,';
    json += 'streamType:1,';
    json += 'drmType:1,';
    json += 'fingerPrint:0,';
    json += 'copyProtection:1,';
    json += 'allowTrickmode:1,';
    json += 'startTime:0,';
    json += 'endTime:100.3,';
    json += 'entryID:"jsonentry1"}]';

    initMediaPlay();
    mp.setSingleMedia(json);
    mp.setAllowTrickmodeFlag(0);

}

</script>