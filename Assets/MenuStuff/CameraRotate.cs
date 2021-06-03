using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraRotate : MonoBehaviour
{
	
	public float speed;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void FixedUpdate()
    {
		transform.Rotate(0, -5 * Time.deltaTime, 0);
		transform.Translate(0, -0.005f * Mathf.Sin(0.05f * Time.time), 0);
    }
}
