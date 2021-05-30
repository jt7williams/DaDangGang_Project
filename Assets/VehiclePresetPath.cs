using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VehiclePresetPath : MonoBehaviour
{
    public GameObject[] waypoints;
    public GameObject vehicle;
    public float speed;
    //public float deltaRotation;
    private int currWaypoint;
    private Rigidbody rb;
    private Vector3 vector2d = new Vector3(1f, 0f, 1f);
    private Vector3 StraightPath;

    public Vector3 rotationSpeed = new Vector3(0, .1f, 0);



    // Start is called before the first frame update
    void Start()
    {
        //Alighn the game objecst so they look at the next;
        for (int cnt = 0; cnt < waypoints.Length - 1; cnt++)
        {
            waypoints[cnt].transform.LookAt(waypoints[cnt+1].transform.position);
        }

        currWaypoint = 0;

        speed = 10f;

        rb = GetComponent<Rigidbody>();
    }

    void Update() { 



        
    }
    void FixedUpdate() {
        MoveVehicle(waypoints[currWaypoint]);

    }

    void MoveVehicle(GameObject wpts){

        float distance = Vector3.Distance(transform.position, wpts.transform.position);
        Vector3 StraightPath = wpts.transform.position - transform.position;

        Vector3 PositionOffset = new Vector3(StraightPath.x, 0f, StraightPath.z);

        if (distance < 5f)
        {

            if (transform.rotation.y < wpts.transform.rotation.y - .01f )
            {
                Quaternion deltaRotation = Quaternion.Euler(wpts.transform.rotation.y * rotationSpeed * 1f);
                rb.MoveRotation(rb.transform.rotation * deltaRotation);
            }
            if (transform.rotation.y < wpts.transform.rotation.y + 0.1f)
            {
                Quaternion deltaRotation = Quaternion.Euler(wpts.transform.rotation.y * rotationSpeed * -1f);
                rb.MoveRotation(rb.transform.rotation * deltaRotation);
            }
            
        }
        else
        {
            if (currWaypoint > 0)
            {
                if (transform.rotation.y < waypoints[currWaypoint - 1].transform.rotation.y - .01f)
                {
                    Quaternion deltaRotation = Quaternion.Euler(waypoints[currWaypoint - 1].transform.rotation.y * rotationSpeed * 1f);
                    rb.MoveRotation(rb.transform.rotation * deltaRotation);
                }
                else if (transform.rotation.y > waypoints[currWaypoint - 1].transform.rotation.y + .01f)
                    {
                        Quaternion deltaRotation = Quaternion.Euler(waypoints[currWaypoint - 1].transform.rotation.y * rotationSpeed * -1f);
                        rb.MoveRotation(rb.transform.rotation * deltaRotation);
                    }
            }

        }





        if (distance > 5f)
        {

            rb.MovePosition(rb.transform.position + PositionOffset.normalized * speed * Time.deltaTime );


        }
        else
        {
            currWaypoint++;


        }
       
     }
}
