- (void) application: (DDCliApplication *) app
    willParseOptions: (DDGetoptLong *) options;
{
    DDGetoptOption optionTable[] = 
    {
        // Long         Short   Argument options
        {@"output",     'o',    DDGetoptRequiredArgument},
        {@"help",       'h',    DDGetoptNoArgument},
        {nil,           0,      0},
    };
    [options addOptionsFromTable: optionTable];
}
