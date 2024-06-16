using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

[CreateAssetMenu(fileName = "New Level", menuName = "Scriptable Objects/Level")]
public class Level : ScriptableObject
{
    [Header("Level Type/Conditions")]
    public int moveLimit;
    public bool isMysteryLevel;

    [Header("Holders Design")]
    public int columnPerRow;
    public int rowNumbers;
    public float firstRowHeight; //the height of which the first row should be positioned to 

    [Header("Cube Pieces Design")]
    public Wood[] woodTypeInLevel;
    public void GenerateCubePiece()
    {
        if (generateMode)
        {
            WoodTypeRowsArrayInstantiate();

            int rowIndex = 0;

            List<Wood> woodTypeInLevelTemp = woodTypeInLevel.ToList(); //a subtitute list that represent the data needed in a level

            List<int> pieceLimit = new List<int>();
            for(int i = 0; i < woodTypeInLevelTemp.Count; i++)
            {
                pieceLimit.Add(4); //each level can only contain 4 piece of the same color
            }

            for (int holderNumber = 1; holderNumber <= woodTypeInLevelTemp.Count; holderNumber++) //the length of woodTypeInLeve will always be equal to the number of holder with pieces in it
            {
                int colIndex = holderNumber - (rowIndex * columnPerRow) - 1;

                WoodDataVisualizer rowData = woodTypeRows[rowIndex];
                WoodDataVisualizer.RowData rowHolderData = rowData.column[colIndex];

                for (int i = 0; i < rowHolderData.holder.Length; i++)
                {
                    int woodTypeIndex = Random.Range(0, woodTypeInLevelTemp.Count);
                    Debug.Log(woodTypeIndex);

                    Wood woodData = woodTypeInLevel[woodTypeIndex];
                    rowHolderData.holder[i] = woodData;

                    pieceLimit[woodTypeIndex]--;
                    if (pieceLimit[woodTypeIndex] == 0)
                    {
                        woodTypeInLevelTemp.RemoveAt(woodTypeIndex);
                        pieceLimit.RemoveAt(woodTypeIndex); //piece limit should also remove the element of that index to keep track of the order
                    }
                }

                //switch row if current holder number has reached the last holder of a row
                if (holderNumber % columnPerRow == 0) rowIndex++;
            }
        }
    }

    [Header("Level Design")]
    public WoodDataVisualizer[] woodTypeRows;
    public bool generateMode;
    private void WoodTypeRowsArrayInstantiate()
    {
        //Generating rows number
        woodTypeRows = new WoodDataVisualizer[rowNumbers];
        for (int i = 0; i < rowNumbers; i++)
        {
            woodTypeRows[i] = new WoodDataVisualizer();

            //Generating column (holders) number per row
            woodTypeRows[i].column = new WoodDataVisualizer.RowData[columnPerRow];

            for (int j = 0; j < columnPerRow; j++)
            {
                woodTypeRows[i].column[j].holder = new Wood[4];
            }
        }
    }
}
