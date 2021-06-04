using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class sceneLoader : MonoBehaviour
{
	
	public Image img;
	private float targetAlpha;
	public float FadeRate;
	
	private bool startedLoading;
	
    public void LoadGame()
    {
		StartCoroutine(StartLoadScene());

    }
	
	IEnumerator StartLoadScene()
	{
		if (startedLoading == true)
		{
			StartCoroutine(StartLoading());
			yield return new WaitForSeconds(3.0f);
			
			SceneManager.LoadScene(2);
			Time.timeScale = 1f;
			startedLoading = false;
		}
	}
	
	IEnumerator StartLoading()
	{
		{
			Color curColor = img.color;
			curColor.a = 0.0f;
			img.color = curColor;
			yield return StartCoroutine(FadeToBlack());
		}
	}
    
	IEnumerator FadeToBlack()
	{
		targetAlpha = 1.0f;
		Color curColor = img.color;
		Debug.Log("FadeOut");
		while(Mathf.Abs(curColor.a - targetAlpha) > 0.01f) {
			
			//curColor.a = Mathf.Lerp(curColor.a, targetAlpha, FadeRate * Time.deltaTime);
			curColor.a = curColor.a + 0.01f;
			img.color = curColor;
			yield return null;
		}
		curColor.a = targetAlpha;
		img.color = curColor;
		//Debug.Log(img.color.a);
	}
	
	public void QuitGame()
    {
        Application.Quit();
        Debug.Log("Quit Game");
    }

    public void vrSelect()
    {
        StateNameController.camNumber = 1;
    }

    public void kbmSelect()
    {
        StateNameController.camNumber = 2;
    }
}
