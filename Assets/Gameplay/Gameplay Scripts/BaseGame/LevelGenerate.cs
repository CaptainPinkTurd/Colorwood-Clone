using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelGenerate : MonoBehaviour
{
    [SerializeField] internal Level level;
    [SerializeField] GameObject woodHolder;
    [SerializeField] GameObject parentRow;
    [SerializeField] GameObject cube;

    private List<float> colPositions;
    private float rowPositon;

    const float rowDistance = 2.8f;
    const float holderDistance = 0.75f;


    public void GenerateLevel()
    {
        for(int row = 0; row < level.rowNumbers; row++)
        {
            WoodDataVisualizer rowData = level.woodTypeRows[row];

            colPositions = CalculateColPos(level.columnPerRow); 
            rowPositon = level.firstRowHeight - (row * rowDistance);

            //Generate a row parent for each new row
            Vector3 rowParentPos = new Vector3(0, rowPositon, 0);
            GameObject rowParent = Instantiate(parentRow, rowParentPos, Quaternion.identity);
            rowParent.name = "Row #" + (row + 1);

            for(int col = 0; col < level.columnPerRow; col++)
            {
                WoodDataVisualizer.RowData rowColData = rowData.column[col];

                Vector3 spawnPos = new Vector3(colPositions[col], rowPositon, 0);
                GameObject holder = Instantiate(woodHolder, spawnPos, Quaternion.identity);
                holder.transform.parent = rowParent.transform;

                for(int i = 0; i < rowColData.holder.Length; i++)
                {
                    Vector3 cubePos = new Vector3(0, DataManager.heightDifference * i, 0);
                    GameObject cubePiece = Instantiate(cube, Vector3.zero, Quaternion.identity, holder.transform);
                    cubePiece.transform.localPosition = cubePos;

                    cubePiece.GetComponent<CubePiece>().wood = rowColData.holder[i];
                    cubePiece.GetComponent<CubePiece>().OnWoodChange();
                }
                holder.GetComponent<WoodHolder>().CubeChunkInitializer(false); //group pieces in wood holder in a singular chunk
                
                holder.GetComponent<WoodHolder>().StackingChunks(); //stacking chunks in order

                holder.GetComponent<WoodHolder>().LayerSort(); //reposition the overlapping cube

                if(level.isMysteryLevel)
                {
                    holder.GetComponent<WoodHolder>().MysteryCubeSetUp(); //setting up mystery cube sprite

                    holder.GetComponent<WoodHolder>().ChunkStackReveal(); //reveal all the cube pieces currently on top of the holder
                } 
            }
            //Since level scene will always be additive, we have to make sure that the game object spawn in level scene will always be in level scene
            SceneManager.MoveGameObjectToScene(rowParent, SceneManager.GetSceneByBuildIndex((int)EnumData.SceneIndexes.LEVEL));
        }
    }
    List<float> CalculateColPos(float colPerRow)
    {
        List<float> tempList = new List<float>();
        float colPos;
        int posIndex;

        if(colPerRow % 2 == 0)
        {
            posIndex = -(int)(colPerRow / 2);
            float xPosOffset = holderDistance / 2; //even column numbers needs to be equally distributed

            for (int i = 0; i < colPerRow; i++)
            {
                colPos = xPosOffset + (holderDistance * posIndex);
                tempList.Add(colPos);   
                posIndex++;
            }
        }
        else
        {
            posIndex = -(int)((colPerRow - 1) / 2);

            for (int i = 0; i < colPerRow; i++)
            {
                colPos = holderDistance * posIndex;
                tempList.Add(colPos);
                posIndex++;
            }
        }
        return tempList;
    }
}
