using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class LoadScreen : MonoBehaviour
{
	public Image img;
	private float targetAlpha;
	public float FadeRate;
	
    // Start is called before the first frame update
    void Start()
    {
		
        StartCoroutine(LoadBegin());

    }

    // Update is called once per frame
    void Update()
    {
		
    }
	
	IEnumerator LoadBegin()
	{
		{
			yield return new WaitForSeconds(2);
			yield return StartCoroutine(FadeToTransparent());
			yield return new WaitForSeconds(2);
			yield return StartCoroutine(FadeToBlack());
			SceneManager.LoadScene("MainMenu");
		}
	}
	
	IEnumerator FadeToTransparent()
	{
		targetAlpha = 0.0f;
		Color curColor = img.color;
		Debug.Log("FadeToTransparent");
		while(Mathf.Abs(curColor.a - targetAlpha) > 0.01f) {
			
			curColor.a = curColor.a - 0.01f;
			img.color = curColor;
			yield return null;
		}
		curColor.a = targetAlpha;
		img.color = curColor;
		//Debug.Log(img.color.a);
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
	

	
}