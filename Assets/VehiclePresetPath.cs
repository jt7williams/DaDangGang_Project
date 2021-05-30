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

    //public Vector3 rotationSpeed = new Vector3(0, .1f, 0);

    public WheelCollider[] wheels;
    public float turnSpeed = 30;

    // Start is called before the first frame update
    void Start()
    {
        //Alighn the game objecst so they look at the next;
        for (int cnt = 0; cnt < waypoints.Length - 1; cnt++)
        {
            waypoints[cnt].transform.LookAt(waypoints[cnt+1].transform.position);
        }

        currWaypoint = 0;

        //speed = 10f;

        rb = GetComponent<Rigidbody>();
        for (int i = 0; i < 4; ++i)
        {
            wheels[i].brakeTorque = 5000F * 0.1F;

        }
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
            /*
            if (transform.rotation.y < wpts.transform.rotation.y - .01f )
            {
                Quaternion deltaRotation = Quaternion.Euler(wpts.transform.rotation.y * rotationSpeed * 1f * Time.fixedDeltaTime);
                rb.MoveRotation(rb.transform.rotation * deltaRotation);
            }
            if (transform.rotation.y > wpts.transform.rotation.y + 0.01f)
            {
                Quaternion deltaRotation = Quaternion.Euler(wpts.transform.rotation.y * rotationSpeed * -1f *Time.fixedDeltaTime);
                rb.MoveRotation(rb.transform.rotation * deltaRotation);
            }*/
            
            rb.MoveRotation(Quaternion.RotateTowards(transform.rotation, wpts.transform.rotation, turnSpeed * Time.fixedDeltaTime));
            
        }
        else
        {
            if (currWaypoint > 0)
            {
                /*
                if (transform.rotation.y < waypoints[currWaypoint - 1].transform.rotation.y - .01f)
                {
                    Quaternion deltaRotation = Quaternion.Euler(waypoints[currWaypoint - 1].transform.rotation.y * rotationSpeed * 1f * Time.fixedDeltaTime);
                    rb.MoveRotation(rb.transform.rotation * deltaRotation);
                }
                else if (transform.rotation.y > waypoints[currWaypoint - 1].transform.rotation.y + .01f)
                    {
                        Quaternion deltaRotation = Quaternion.Euler(waypoints[currWaypoint - 1].transform.rotation.y * rotationSpeed * -1f * Time.fixedDeltaTime);
                        rb.MoveRotation(rb.transform.rotation * deltaRotation);
                    }
                    */
                
                rb.MoveRotation(Quaternion.RotateTowards(transform.rotation, waypoints[currWaypoint - 1].transform.rotation, turnSpeed * Time.fixedDeltaTime));
                
            }

        }





        if (distance > 5f)
        {

            rb.MovePosition(rb.transform.position + PositionOffset.normalized * speed * Time.fixedDeltaTime );
            
            

        }
        else
        {
            currWaypoint++;

            
        }
       
     }
}
