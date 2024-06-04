using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Mkey
{
    public class LevelButton : MonoBehaviour
    {
        public Level level;

        public Color currentLevel;
        public Color currentHardLevel;
        public Color notCurrentLevel;
        public GameObject Lock;
        public Button button;
        public TMP_Text numberText;
        public GameEvent levelSelectEvent;
        public bool Interactable { get; private set; }

        /// <summary>
        /// Set button interactable if button "active" or appropriate level is passed. Show stars or Lock image
        /// </summary>
        /// <param name="active"></param>
        /// <param name="activeStarsCount"></param>
        /// <param name="isPassed"></param>
        internal void SetActive(bool active, int activeStarsCount, bool isPassed)
        {
            Interactable = active || isPassed;
            if(button)  button.interactable = Interactable;
            if (active)
            {
                MapController.Instance.ActiveButton = this;
            }

            if(Lock) Lock.SetActive(!isPassed && !active);
        }
        public void LevelSelectText(TMP_Text text)
        {
            text.text = "Level " + numberText;
        }
    }
}