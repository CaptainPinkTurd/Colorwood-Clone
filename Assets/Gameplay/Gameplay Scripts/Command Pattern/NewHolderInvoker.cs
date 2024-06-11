using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewHolderInvoker 
{
    Stack<ICommand> commandList;
    public NewHolderInvoker()
    {
        commandList = new Stack<ICommand>();
        GameManager.onUndo += UndoCommand;
    }

    public void AddCommand(ICommand newCommand)
    {
        newCommand.Execute();
        commandList.Push(newCommand); //register the entire object with all of its assigned values in
    }
    public void UndoCommand()
    {
        if(commandList.Count > 0)
        {
            ICommand latestCommand = commandList.Pop(); //pull out latest register object with all of its value intact and undo it
            latestCommand.Undo(); 
        }
    }
}
