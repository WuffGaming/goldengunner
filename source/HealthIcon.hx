package;

import flixel.FlxSprite;
import flixel.math.FlxMath;

typedef IconData =
{
	var size:Null<Int>;

	var scale:Array<Float>;

	var solo:Null<Bool>;

	var antialiasing:Null<Bool>;

	var awesome:Null<Bool>;

	var flip:Null<Bool>;

	var animations:Array<IconAnimationData>;
}

typedef IconAnimationData = // taken from gapple:e
{
	var name:String; // Name of animation. Should be something like "Normal" or "Losing"
	var prefix:String; // Name of animation in XML

	/**
	 * Whether this animation is looped.
	 * @default false
	 */
	var ?looped:Bool;

	/**
	 * The frame rate of this animation.
	 * @default 24
	 */
	var ?frameRate:Int; // Framerate of this specific animation.

	var ?frameIndices:Array<Int>; // If using indices, specify said indices. Plays full animation if null.
}

class HealthIcon extends FlxSprite
{
	public var isPlayer:Bool = false;

	public var charPublic:String = 'bf';
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public var animatedIcon:Bool = false;

	public var losing:Bool = false;

	public var singleIcon:Bool = false;

	public var iconScale:Array<Float> = [1, 1];

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;

		changeIcon(char);

		scrollFactor.set();
	}

	function addIcon(char:String, startFrame:Int, singleIcon:Bool = false, flipOpposite:Bool = false)
	{
		var flip:Bool = isPlayer;
		if(flipOpposite){flip = !flip;};
		animation.add(char, !singleIcon ? [startFrame, startFrame + 1] : [startFrame], 0, false, flip);
	}

	function addAwesomeIcon(char:String, startFrame:Int, singleIcon:Bool = false, flipOpposite:Bool = false)
	{
		var flip:Bool = isPlayer;
		if(flipOpposite){flip = !flip;};
		if(char == 'awesomePlayer')
		{
			animation.add(char, [5, 1, 3], 0, false, !isPlayer);
		}
		else
		{
			animation.add(char, [4, 0, 2], 0, false, isPlayer);
		}
	}

	public function changeIcon(char:String = 'face')
	{
		charPublic = char;

		if (Assets.exists(Paths.jsonImg('icons/${char}')))
		{
			var jsonData:IconData = Paths.loadJSONImg('icons/${char}');
			var data:IconData = cast jsonData;
			var size:Int = data.size == null ? 150 : data.size;
			var solo:Bool = data.solo == null ? false : data.solo;
			var anti:Bool = data.antialiasing == null ? true : data.antialiasing;
			var awesome:Bool = data.awesome == null ? false : data.awesome;
			var flip:Bool = data.flip == null ? false : data.flip;

			if (anti != true)
				antialiasing = false;

			if (solo == true)
				singleIcon = true;
			
			if (data.animations != null)
			{
				trace('${char} is an animated icon! Wow!');
				animatedIcon = true;
				frames = Paths.getSparrowAtlas('icons/${char}');
				for (anim in data.animations)
				{
					var frameRate = anim.frameRate == null ? 24 : anim.frameRate;
					var looped = anim.looped == null ? false : anim.looped;

					if (anim.frameIndices != null)
					{
						animation.addByIndices(anim.name, anim.prefix, anim.frameIndices, "", frameRate, looped, isPlayer);
					}
					else
					{
						animation.addByPrefix(anim.name, anim.prefix, frameRate, looped, isPlayer);
					}
				}
				animation.play('normal', true);
			}
			else
			{
				loadGraphic(Paths.image('icons/${char}'), true, size, size);
				if (awesome)
					addAwesomeIcon(char, 0, solo, flip);
				else
					addIcon(char, 0, solo, flip);
			}
		}
		else
		{
			loadGraphic(Paths.image('icons/${char}'), true, 150, 150);

			addIcon(char, 0);
		}
		setGraphicSize(width * iconScale[0], height * iconScale[1]);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var xOffsetPenis:Float = 0;
		var yOffsetPenis:Float = 0;

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);

		offset.set(Std.int(FlxMath.bound(width - (150 * scale.x),0)) + xOffsetPenis,Std.int(FlxMath.bound(height - (150 * scale.y),0)) + yOffsetPenis);
	}
}
