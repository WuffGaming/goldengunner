package;

import flixel.FlxG;
import sys.io.File;
import openfl.system.System;
import lime.utils.Assets;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD","LEGACY"];

	public static function isSecretSong(song:String) 
	{
		return false;
	}

	public static function cheatersNeverProsper()
	{
		FlxG.save.flush();
		SaveFileState.saveFile.flush();
		Sys.command("start assets/data/caught.txt");
		System.exit(0);
	}


	public static function difficultyString():String
	{
		switch (PlayState.storyWeek)
		{
			case 3:
				return 'FINALE';
			default:
				return difficultyArray[PlayState.storyDifficulty];
		}
	}

	public static function boundTo(value:Float, min:Float, max:Float):Float
	{
		var newValue:Float = value;
		if(newValue < min) newValue = min;
		else if(newValue > max) newValue = max;
		return newValue;
	}

	public static function songDiffRating(song:String)
	{
		var diff:String = 'unknown';
		switch(song.toLowerCase())
		{
			case 'applecore' | 'applecore-(short-mix)':
				diff = 'extreme';
			case 'disruption' | 'sugar-rush' | 'ferocious' | 'ferocious-(short-mix)' | 'gift-card' | 'og-(original-draft)' | 'ripple' | 'deformation' | 'algebra-(pre-release-teaser)' | 'algebra-(legacy-mix)' | 'slices' | 'ready-loud':
				diff = 'hard';
			case 'mine' | 'bookworm' | 'disability' | '3po-jam' | 'dale' | 'recovered-project' | 'recovered-project-(short-version)' | 'recovered-project-(ingame-version)' | 'keyboard' | 'cell' | 'wireframe' | 'ticking' | 'ticking-(1.5-teaser)' | 'unhinged' | 'cuberoot-(alpha-mix)' | 'cuberoot' | 'thunderstorm' | 'too-shiny' | 'apprentice-(beta-mix)' | 'apprentice' | 'tantalum':
				diff = 'normal';
			case 'origin' | 'strawberry' | 'the-big-dingle' | 'corrupted-file' | 'sick-tricks' | 'dave-x-bambi-shipping-cute' | 'dave-x-bambi-shipping-cute-(removed-version)' | 'wheels' | 'alternate' | 'cycles' | 'resumed':
				diff = 'easy';
			case 'unknown':
				diff = 'uncharted';
			default:
				diff = 'unknown';
		}
		return diff;
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}
	
	public static function coolStringFile(path:String):Array<String>
		{
			var daList:Array<String> = path.trim().split('\n');
	
			for (i in 0...daList.length)
			{
				daList[i] = daList[i].trim();
			}
	
			return daList;
		}

	public static function dominantColor(sprite:flixel.FlxSprite):Int
	{
		var countByColor:Map<Int, Int> = [];
		for(col in 0...sprite.frameWidth){
			for(row in 0...sprite.frameHeight){
			  var colorOfThisPixel:Int = sprite.pixels.getPixel32(col, row);
			  if(colorOfThisPixel != 0){
				  if(countByColor.exists(colorOfThisPixel)){
				    countByColor[colorOfThisPixel] =  countByColor[colorOfThisPixel] + 1;
				  }else if(countByColor[colorOfThisPixel] != 13520687 - (2*13520687)){
					 countByColor[colorOfThisPixel] = 1;
				  }
			  }
			}
		 }
		var maxCount = 0;
		var maxKey:Int = 0;//after the loop this will store the max color
		countByColor[flixel.util.FlxColor.BLACK] = 0;
			for(key in countByColor.keys()){
			if(countByColor[key] >= maxCount){
				maxCount = countByColor[key];
				maxKey = key;
			}
		}
		return maxKey;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}
	public static function formatString(string:String):String
		{
			 var split:Array<String> = string.split('-');
			 var formattedString:String = '';
			 for (i in 0...split.length) 
			 {
				  var piece:String = split[i];
				  var allSplit = piece.split('');
				  var firstLetterUpperCased = allSplit[0].toUpperCase();
				  var substring = piece.substr(1, piece.length - 1);
				  var newPiece = firstLetterUpperCased + substring;
				  if (i != split.length - 1)
				  {
						newPiece += " ";
				  }
				  formattedString += newPiece;
			 }
			 return formattedString;
		}
}
