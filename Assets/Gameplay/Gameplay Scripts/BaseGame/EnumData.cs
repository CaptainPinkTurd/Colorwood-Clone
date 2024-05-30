using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnumData
{
    public enum WoodType
    {
        Yellow,
        Blue,
        Purple,
        Red,
        Green,
        Lime,
        Cyan,
        Pink,
        Orange
    };

    public enum SceneIndexes
    {
        PERSISTENT_SCENE = 0,
        LOBBY = 1,
        LEVEL = 2
    }
}
