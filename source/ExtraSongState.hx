package;

import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxStringUtil;
import lime.utils.Assets;
#if desktop
import Discord.DiscordClient;
#end
import sys.FileSystem;
using StringTools;

class ExtraSongState extends MusicBeatState
{
	var gfSpeed:Int = 1;
	override function beatHit()
	{
		for(iconP2 in iconArray)
		{
			iconP2.scale.set(1.2, 1.2);
			iconP2.updateHitbox();
		}
		super.beatHit();
	}

    var songs:Array<SongMetadata> = [];

    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('backgrounds/SUSSUS AMOGUS'));
    var curSelected:Int = 0;

    private var iconArray:Array<HealthIcon> = [];

    var swagText:FlxText = new FlxText(0, 0, FlxG.width, 'my poop is brimming', 85);
	var awesomeText:FlxText = new FlxText(0, 0, FlxG.width, 'Press space to view the OG mod!', 85);

    var songColors:Array<FlxColor> = [
    	0xFFca1f6f, // GF 0
		0xFF4965FF, // DAVE 1
		0xFF00B515, // MISTER 2 BAMBI r slur (i cant reclaim) //MISTER BAMBI RETARD (i can though)
		0xFF00FFFF, //SPLIT THE THONNNNN 3
		0xFF000000, // sart. 4
		FlxColor.YELLOW, //GARRETT???? 5
		FlxColor.WHITE, //leaked recovered project full week you gett it
		FlxColor.GRAY, //HOLY SHIT ITS PLAYROBOT!!! 7
		FlxColor.LIME, //ALIEN?!?!?!?! 8
		FlxColor.BLUE //DIAMOND MAN!??!?!9?!?!?!?
    ];

	var logos:Array<FlxSprite> = [];
    
    private var grpSongs:FlxTypedGroup<Alphabet>;

	public override function new()
	{
		super();
	}

    override function create() 
	{
		
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		swagText.antialiasing = true;
		awesomeText.antialiasing = true;

        #if desktop DiscordClient.changePresence("In the Extra Songs Menu", null); #end

        bg.loadGraphic(MainMenuState.randomizeBG());
		bg.color = 0xFF4965FF;
		add(bg);

		addSong('Apprentice-(Beta-Mix)', 0, 'tristan');
		addSong('RECOVERED-PROJECT-(Ingame-Version)', 6, 'recovered');
		addSong('Cuberoot-(Alpha-Mix)', 1, 'disability');
		addSong('Ferocious-(Short-Mix)', 5, 'garrett-animal');
		addSong('AppleCore-(Short-Mix)', 0, 'unfair');
		addSong('OG-(Original-Draft)', 6, 'prealpha');
		addSong('Algebra-(Pre-Release-Teaser)', 1, 'og-dave');
		addSong('Dave-x-Bambi-Shipping-Cute-(Removed-Version)', 2, 'dab');
		//addSong('', , '');

        grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

        swagText.setFormat("Comic Sans MS Bold", 48, FlxColor.BLACK, CENTER);
		swagText.screenCenter(X);
		swagText.y += 50;
		add(swagText);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

            var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;
			if(songs[i].blackoutIcon)
			{
				icon.color = FlxColor.BLACK;
			}

			iconArray.push(icon);
			add(icon);
		}

		for (i in logos)  {
			i.setGraphicSize(500);
			i.screenCenter();
			i.x += 275;
			add(i);
		}

		changeSelection();

		updateDiffies();

        super.create();
    }

    public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
            if (!checkSongUnlock(song))
                addSong('unknown', 4, songCharacters[num], true);
            else
			    addSong(song, weekNum, songCharacters[num], false);

			if (songCharacters.length != 1)
				num++;
		}
	}

	public function checkSongUnlock(song:String)
	{
		return true;
	}

    public function addSong(songName:String, weekNum:Int, songCharacter:String, blackoutIcon:Bool = false)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, blackoutIcon));
	}

    override function update(p:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		Conductor.songPosition = FlxG.sound.music.time;

		for(iconP2 in iconArray)
		{
			var mult:Float = FlxMath.lerp(1, iconP2.scale.x, CoolUtil.boundTo(1 - (p * 9), 0, 1));
			iconP2.scale.set(mult, mult);
			iconP2.updateHitbox();
		}

        super.update(p);

        if (controls.UP_P)
            changeSelection(-1);

        if (controls.DOWN_P)
            changeSelection(1);

        if (controls.BACK)
            FlxG.switchState(()->new MainMenuState());

        if (controls.ACCEPT || FlxG.keys.justPressed.ENTER)
		{
            switch (songs[curSelected].songName.toLowerCase()) {
                case 'unknown':
                    FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					FlxG.camera.shake(0.05, Conductor.stepCrochet / 1000, null, true);
				case 'OG-(Original-Draft)':
                    FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					swagText.text = 'You fucked the\nBPM up bro!!!';
                	swagText.visible = true;
					swagText.alpha = 1;
					FlxTween.tween(swagText, {alpha: 0}, 1);
					FlxG.camera.shake(0.05, Conductor.stepCrochet / 1000, null, true);
                default:   
					var pisswad = songs[curSelected].songName.toLowerCase();

                    var poop:String = Highscore.formatSong(pisswad, 1);

                    trace(poop);

                    PlayState.SONG = Song.loadFromJson(poop, pisswad);

                    PlayState.isStoryMode = false;

                    PlayState.storyDifficulty = 1;

                    PlayState.xtraSong = true;

					PlayState.formoverride = 'none';

					PlayState.practicing = false;
			
					PlayState.fakedScore = false;
			
					PlayState.deathCounter = 0;

                    PlayState.storyWeek = songs[curSelected].week;
					if(songs[curSelected].songName.toLowerCase() == 'midnight' || songs[curSelected].songName.toLowerCase() == 'ready-loud' || songs[curSelected].songName.toLowerCase() == 'irreversible-action' || songs[curSelected].songName.toLowerCase() == 'cuberoot' || songs[curSelected].songName.toLowerCase() == 'dave-x-bambi-shipping-cute' || songs[curSelected].songName.toLowerCase() == 'cheating-not-cute' || songs[curSelected].songName.toLowerCase() == 'left-unchecked' || songs[curSelected].songName.toLowerCase() == 'collision')
					{
						LoadingState.loadAndSwitchState(new PlayState());
					}
					else
					{
						LoadingState.loadAndSwitchState(new CharacterSelectState());
					}
            }
		}
    }

    function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;

		if (curSelected >= songs.length)
			curSelected = 0;

        switch(songs[curSelected].songName.toLowerCase()) {
            case 'unknown':
                swagText.text = 'A secret is required to unlock this song!';
                swagText.visible = true;
				swagText.alpha = 1;
            default:
				swagText.alpha = 0;
                swagText.visible = false;
        }

		var bullShit:Int = 0;

        for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}

		for (i in logos) {
			i.visible = logos.indexOf(i) == curSelected;
		}

		updateDiffies();

		FlxTween.color(bg, 0.25, bg.color, songColors[songs[curSelected].week]);
	}

	var difficultyImg:FlxSprite;

	function updateDiffies() 
	{
		if(difficultyImg != null)
		{
			remove(difficultyImg);
		}
		difficultyImg = new FlxSprite();
		difficultyImg.loadGraphic(Paths.image('diff/' + CoolUtil.songDiffRating(songs[curSelected].songName.toLowerCase())));
		difficultyImg.scale.set(0.5, 0.5);
		difficultyImg.setPosition(FlxG.width - ((546 / 1.4) + 5), FlxG.height - ((497 / 1.4) + 5));
		difficultyImg.scrollFactor.set(0, 0);
		add(difficultyImg);
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var blackoutIcon:Bool = false;

	public function new(song:String, week:Int, songCharacter:String, blackoutIcon:Bool)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.blackoutIcon = blackoutIcon;
	}
}