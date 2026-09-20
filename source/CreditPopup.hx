package;

import flixel.group.FlxSpriteGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.math.FlxMath;

class CreditPopup extends FlxSpriteGroup
{
    public var bitchyBalls:FlxSprite;

    public function new(x:Float, y:Float, songy:String)
    {
        super(x, y);
        bitchyBalls = new FlxSprite().makeGraphic(300, 50, FlxColor.WHITE);
        bitchyBalls.alpha = 0.6;
        add(bitchyBalls);

        var funnyText:FlxText = new FlxText(1, 0, 650, 'Placeholder', 16);
        funnyText.antialiasing = true;
        funnyText.setFormat('Comic Sans MS Bold', 32, FlxColor.BLACK, LEFT);
        switch(songy.toLowerCase())
        {
            case 'disruption' | 'mine' | 'minus-disruption' | 'applecore' | 'applecore-(short-mix)' | 'disability' | '3po-jam' | 'algebra' | 'future' | 'nice' | 'resumed' | 'sugar-rush' | 'recovered-project' | 'recovered-project-(ingame-version)' 
            | 'dave-x-bambi-shipping-cute' | 'bookworm' | 'the-big-dingle' | 'dave-x-bambi-shipping-cute-(removed-version)' | 'algebra-(pre-release-teaser)' | 'recovered-project-(short-version)':
                funnyText.text = 'Song by Grantare';
            case 'ferocious' | 'ferocious-(short-mix)':
                funnyText.text = 'Song by Grantare\nOriginal Mod by Jumpman25';
                bitchyBalls.scale.set(1.75, 2);
                bitchyBalls.y += 35;
                bitchyBalls.x += 10;
            case 'wireframe' | 'origin' | 'tantalum' | 'keyboard' | 'corrupted-file' | 'genocidal' | 'krunker' | 'galactic' | 'you-cheated' | 'sick-tricks' | 'the-boopadoop-song':
                funnyText.text = 'Song by Cynda';
            case 'pool-party' | 'deformation':
                funnyText.text = 'Song by Cynda and Aadsta';
                bitchyBalls.scale.set(2.25, 1);
            case 'fresh-and-toasted':
                funnyText.text = 'Song by R34D34L';
            case 'cuberoot' | 'cuberoot-(alpha-mix)' | 'og-(original-draft)' | 'production' | 'cheating-not-cute' | 'dale' | 'ticking' | 'ticking-(1.5-teaser)' | 'irreversible-action' | 'apprentice' | 'apprentice-(beta-mix)':
                funnyText.text = 'Song by Aadsta';
            case 'nft' | 'upcoming-cop' | 'enforcers' | 'cell' | 'alternate':
                funnyText.text = 'Song by Wildy';
            case 'cooking-lesson':
                funnyText.text = 'Song by Alexander Cooper 19';
                bitchyBalls.scale.set(2.25, 1);
            case 'strawberry':
                funnyText.text = 'Song by Cynda and Grantare';
                bitchyBalls.scale.set(2.25, 1);
            case 'ready-loud' | 'comecful':
                funnyText.text = 'Song by MoldyGH';
            case 'grantare-sings-unfairness':
                funnyText.text = 'Song by MoldyGH\nImprovement by Grantare';
                bitchyBalls.scale.set(1.5, 2);
            case 'gift-card':
                funnyText.text = 'Song by Cval';
            case 'too-shiny':
                funnyText.text = 'Song by Gorbini';
            case 'jack-(1.4-version)' | 'jack-(old-mix)':
                funnyText.text = 'Song by MARKUSGAMING79';
        }
        add(funnyText);
    }
}