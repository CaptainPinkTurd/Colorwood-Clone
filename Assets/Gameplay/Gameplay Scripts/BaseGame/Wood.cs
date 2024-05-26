using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Wood", menuName = "Wood")]
public class Wood : ScriptableObject
{
    public new string name;

    public Sprite woodSprite;

    public CubePiece.WoodType woodType;

    public Color color;
}
