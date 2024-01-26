package modules.fixedshaders;

import flixel.FlxG;

class TemplateShader extends RuntimeFilter {
    private var updateV = 'iTime';

    public function new(fragment:String, ?isUpdate:Bool = false, ?updateVarName:String = 'iTime') {
        super(fragment, null, 120);

        if (isUpdate) {
            updateV = updateVarName;
            setFloat(updateV, 0);
            FlxG.signals.postUpdate.add(() -> update(FlxG.elapsed));
        }
    }

    public function update(elapsed:Float)
        setFloat(updateV, getFloat(updateV) + elapsed);

    override public function toString()
        return glFragmentSource;
}