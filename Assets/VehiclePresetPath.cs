using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VehiclePresetPath : MonoBehaviour
{
    public GameObject[] waypoints;
    public GameObject vehicle;
    public float speed;
    private int currWaypoint;
    private bool newWayPoint;
    private Vector3 travelDir;
    
    // Start is called before the first frame update
    void Start()
    {
        currWaypoint = 0;
        newWayPoint = true;
    }

    // Update is called once per frame
    void Update()
    {
        if (currWaypoint < waypoints.Length)
        {
            if (newWayPoint)
            {
                travelDir = (waypoints[currWaypoint].transform.position - vehicle.transform.position).normalized;
                vehicle.transform.LookAt(waypoints[currWaypoint].transform);
                newWayPoint = false;
            }
            vehicle.transform.position = vehicle.transform.position + (speed * Time.deltaTime) * travelDir;

            if ((vehicle.transform.position - waypoints[currWaypoint].transform.position).magnitude < 0.5F)
            {
                currWaypoint += 1;
                newWayPoint = true;
            }
        }
    }
}
