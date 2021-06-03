using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class DoFControl : MonoBehaviour
{
	Ray raycast;
	RaycastHit hit;
	bool isHit;
	float hitDistance;
	
	public Volume volume;
	DepthOfField depthOfField;
	
    // Start is called before the first frame update
    void Start()
    {
		
        //volume = volumeObject.GetComponent<Volume>();
		DepthOfField temp;
		
        if( volume.profile.TryGet<DepthOfField>( out temp ) )
        {
            depthOfField = temp;
        }
    }

    // Update is called once per frame
    void FixedUpdate()
    {
		/*
        raycast = new Ray(transform.position, transform.forward*400);
		isHit = false;
		
		if (Physics.Raycast(raycast, out hit, 400f))
		{
			isHit = true;
			hitDistance = Vector3.Distance(transform.position, hit.point);
			
		}
		else
		{
			if (hitDistance < 400f)
			{
				hitDistance++;
			}
		}*/
		
		SetDoF();
    }
	
	void SetDoF()
	{
		
		depthOfField.focusDistance.value = 120 + 100 * Mathf.Abs(Mathf.Sin(0.1f * Time.time));
		//Debug.Log(depthOfField.focusDistance.value);
	}

}
