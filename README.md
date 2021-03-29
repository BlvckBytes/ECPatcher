# ECPatcher

## About

The aim of this project is to *finally* automate the tedious process of patching EC-Memory fields greater than 8 bit. If you are like me, and you've completed dozens of patches, you will notice the repetitiveness the whole process brings with itself. Seems like one could easily automate that, right? *Wrong!* Try it yourself, and you will be stuck wondering how you could describe some of the muscle memory we patchers already have as an algorithm, containing all edge-cases.

## My Goal

My goal is to create a python-script that can generate an SSDT-BATT.aml with all it's corresponding renames in OC's format, to just be copy pasted into your current configuration. I'd make this service available to users by hosting it on a web-page for easy access. Maybe also create a rating-system of how good the provided patch worked, and flawless patches will get added into a database. Flaws then obviously occurred automatically and make up for a new chance to improve the tool.

## The Process

For those who don't know already, I'll quickly describe the steps needed to patch EC-Memory.

Generating the region-patch:
* Find all OperationRegions which have "EmbeddedControl" as their RegionSpace
* Find all Fields with those RegionNames, keep track of them since their AccessType, LockRule and UpdateRule may differ
* Go through each of the FieldUnits within these Fields, note down the name, offset and length of FieldUnits greater than 8 bit
* Search for occurrences of that name, which is not within a comment or the definition itself, oh - and also not within other names
* Put all FieldUnits which are bigger than 32 bit to the side, they will be r/w buffered later
* Split up remaining FieldUnits into either 2x8 or 4x8, to be used with B1B2 or B1B4, assign new non-colliding names, that are of the same pattern within units, to make it more readable later on
* Create a new OperationRegion, from 0x0 to 0xFF on EmbeddedControl RegionSace
* Group split up FieldUnits into separate fields using that RegionName, based on their AccessType, LockRule, UpdateRule and colliding offsets
* Add comments with the current offset and former name above these units, for easier debugging

The integration of those newly created FieldUnits differs based on their former size. 2x8 will use B1B2 for read access, 4x8 will use B1B4. Anything bigger needs to be read by invoking RECB with the field's offset and length in bits.

Writing to the EC is basically the same for all sizes, using the buffered write functionality of WECB. Invoke it with the offset, length in bits and the new value to be assigned.

It should be possible to pull this patching process off, but this includes a lot of ASL-interpretation by this tool. Finding methods (beginning, end), properly detect r/w access, detect the scope of dependencies from main DSDT and marking them as external, and so on... We'll see whether or not I'm able to complete this project.
