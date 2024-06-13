using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Wood", menuName = "Scriptable Objects/Wood")]
public class Wood : ScriptableObject
{
    public new string name;

    public Sprite woodSprite;

    public Sprite mysterySprite;

    public EnumData.WoodType woodType;

    public Color color;
}
