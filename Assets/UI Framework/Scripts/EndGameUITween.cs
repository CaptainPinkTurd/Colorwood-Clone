using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndGameUITween : MonoBehaviour
{
    [SerializeField] GameObject backpanel;
    [SerializeField] GameObject winPopup;
    [SerializeField] GameObject tickMark;

    private void Awake()
    {
        winPopup.transform.localScale = Vector3.zero;
        backpanel.transform.localScale = Vector3.zero;
        tickMark.transform.localScale = Vector3.zero;
        tickMark.transform.localPosition = Vector3.zero;
    }
    public void Start()
    {
        LeanTween.scale(winPopup, new Vector3(150, 150, 150), 2f).setDelay(0.5f).setEase(LeanTweenType.easeOutElastic);

        LeanTween.scale(backpanel, new Vector3(1, 1, 1), 0.25f).setDelay(0.5f);
        LeanTween.scale(tickMark, new Vector3(150, 150, 150), 0.25f).setDelay(0.5f);

        LeanTween.moveLocal(tickMark, new Vector3(0, 525, 0), 1.75f).setDelay(0.75f).setEase(LeanTweenType.easeOutElastic).setOnComplete(CloseOffUI);
    }
    private void CloseOffUI()
    {
        LeanTween.moveLocal(tickMark, Vector3.zero, 1.25f).setDelay(0.5f).setEase(LeanTweenType.easeInOutElastic).setOnComplete(ReturnToLobby);
        LeanTween.alpha(backpanel, 0f, 1.75f);
        LeanTween.scale(tickMark, Vector3.zero, 0.5f).setDelay(0.75f);
        LeanTween.scale(winPopup, Vector3.zero, 1.5f).setDelay(0.75f).setEase(LeanTweenType.easeInOutElastic);
    }
    private void ReturnToLobby()
    {
        ViewManager.instance.LoadLobby();
    }
}
