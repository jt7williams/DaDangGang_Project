using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrossHairTarget : MonoBehaviour
{
    Camera MainCamera;
    Ray ray;
    RaycastHit hitInfo;
    void Start()
    {
        MainCamera = Camera.main;
    }

    // Update is called once per frame
    void Update()
    {
        ray.origin = MainCamera.transform.position;
        ray.direction = MainCamera.transform.forward;
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
