using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Level", menuName = "Scriptable Objects/Level")]
public class Level : ScriptableObject
{
    [Header("Level Type/Conditions")]
    public int moveLimit;
    public bool isMysteryLevel;

    [Header("Level Design")]
    public int columnPerRow;
    public int rowNumbers;
    public float firstRowHeight; //the height of which the first row should be positioned to 
    public WoodDataVisualizer[] woodTypeRows;
}
