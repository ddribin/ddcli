- (int) application: (DDCliApplication *) app
   runWithArguments: (NSArray *) arguments;
{
    ddprintf(@"Output: %@, help: %d\n", _output, _help);
    ddprintf(@"Arguments: %@\n", arguments);
    return 0;
}
