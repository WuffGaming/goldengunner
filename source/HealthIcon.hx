package;

import flixel.FlxSprite;
import flixel.math.FlxMath;

typedef IconData =
{
	var size:Null<Int>;

	var scale:Array<Float>;

	var solo:Null<Bool>;

	var antialiasing:Null<Bool>;

	var flip:Null<Bool>;

	var animations:Array<IconAnimationData>;
}

typedef IconAnimationData = // taken from character.hx
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
	/**
	 * Used to represent character icons & the color on the healthbar.
	 */
	public var sprTracker:FlxSprite;

	public var isPlayer:Bool = false;

	public var charPublic:String = 'bf';

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

	function addIcon(char:String, startFrame:Int, singleIcon:Bool = false, flip:Bool = false)
	{
		animation.add(char, !singleIcon ? [startFrame, startFrame + 1] : [startFrame], 0, false, flip ? !isPlayer : isPlayer);
	}

	public function changeIcon(char:String = 'face')
	{
		var iconPath = 'icons/';
		charPublic = char;

		if (Assets.exists(Paths.jsonImg('icons/${char}')))
		{
			var jsonData:IconData = Paths.loadJSONImg('icons/${char}');
			var data:IconData = cast jsonData;
			var size:Int = data.size == null ? 150 : data.size;
			var solo:Bool = data.solo == null ? false : data.solo;
			var anti:Bool = data.antialiasing == null ? true : data.antialiasing;
			var flip:Bool = data.flip == null ? false : data.flip;
			iconScale = data.scale == null ? [1, 1] : [data.scale[0], data.scale[1]];

			if (solo == true)
				singleIcon = true;

			antialiasing = anti;

			if (data.animations != null)
			{
				trace('${char} is an animated icon! Wow!');
				animatedIcon = true;
				frames = Paths.getSparrowAtlas(iconPath + char);
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
				loadGraphic(Paths.image(iconPath + char), true, size, size);
				addIcon(char, 0, solo, flip);
			}
		}
		else
		{
			loadGraphic(Paths.image(iconPath + char), true, 150, 150);

			addIcon(char, 0);
		}

		setGraphicSize(width * iconScale[0], height * iconScale[1]);
		updateHitbox();

		animation.play(char);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		offset.set(Std.int(FlxMath.bound(width - 150, 0)), Std.int(FlxMath.bound(height - 150, 0)));

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
