using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OVRCrossHair : MonoBehaviour
{
    public GameObject crossHairTransform;
    Ray ray;
    RaycastHit hitInfo;
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        ray.origin = crossHairTransform.transform.position;
        ray.direction = crossHairTransform.transform.forward;
        if (Physics.Raycast(ray, out hitInfo))
        {
            transform.position = hitInfo.point;
        }
        else
        {
            transform.position = ray.origin + ray.direction * 1000.0f;
        }
    }
}
