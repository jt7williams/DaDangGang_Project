using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VehiclePresetPath : MonoBehaviour
{
    public GameObject[] waypoints;
    public GameObject vehicle;
    public float VehicleSpeed;
    private float speed;
    //public float deltaRotation;
    private int currWaypoint;
    private Rigidbody rb;
    private Vector3 vector2d = new Vector3(1f, 0f, 1f);
    private Vector3 StraightPath;

    public AudioSource EngineSound;
    public AudioSource TankSound;
    public AudioSource[] TrackSound;


    public WheelCollider[] wheels;
    private float turnSpeed = 30;

    // Start is called before the first frame update
    void Start()
    {
        //Alighn the game objecst so they look at the next;
        for (int cnt = 0; cnt < waypoints.Length - 1; cnt++)
        {
            Vector3 pos = waypoints[cnt].transform.position;
            waypoints[cnt].transform.LookAt(waypoints[cnt + 1].transform.position);
            pos.y = Terrain.activeTerrain.SampleHeight(waypoints[cnt].transform.position) + 3.8f;
            waypoints[cnt].transform.position = pos;

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
    void FixedUpdate()
    {
        //When the vehicle hits a steep incline then increase the speed by 5f. 
        if (transform.eulerAngles.x > 300f && transform.eulerAngles.x < 350f)
        {
            Debug.Log("increasing speed.\n");
            speed = VehicleSpeed + 5f;
        }
        else
            speed = VehicleSpeed;

        turnSpeed = 6 * speed;
        if (currWaypoint < waypoints.Length)
        {
            MoveVehicle(waypoints[currWaypoint]);

            //We are moving play sounds
            if (!TankSound.isPlaying)
            {
                TankSound.Play();
                EngineSound.Play();

                TrackSound[0].Play();
                TrackSound[1].Play();
                TrackSound[2].Play();
                TrackSound[3].Play();
            }


        }
        else {

            TankSound.Pause();
            EngineSound.Pause();

            TrackSound[0].Pause();
            TrackSound[1].Pause();
            TrackSound[2].Pause();
            TrackSound[3].Pause();

        }



    }

    void MoveVehicle(GameObject wpts){

        float distance = Vector3.Distance(transform.position, wpts.transform.position);
        Vector3 StraightPath = wpts.transform.position - transform.position;

        Vector3 PositionOffset = new Vector3(StraightPath.x, 0f, StraightPath.z);

        
        if (distance < 5f)
        {
            
            if ((transform.rotation.y < wpts.transform.rotation.y - .01f) || (transform.rotation.y > wpts.transform.rotation.y + 0.01f)) {
                rb.MoveRotation(Quaternion.RotateTowards(transform.rotation, wpts.transform.rotation, turnSpeed * Time.fixedDeltaTime));
            }

        }
        else
        {
            if (currWaypoint > 0)
            {
         
                if ((transform.rotation.y < waypoints[currWaypoint - 1].transform.rotation.y - .01f) || (transform.rotation.y > waypoints[currWaypoint - 1].transform.rotation.y + .01f))
                {
                    rb.MoveRotation(Quaternion.RotateTowards(transform.rotation, waypoints[currWaypoint - 1].transform.rotation, turnSpeed * Time.fixedDeltaTime));
                }
                
            }

        }
        





        if (distance > 5f)
        {

            rb.MovePosition(rb.transform.position + PositionOffset.normalized * speed * Time.fixedDeltaTime);
            
            

        }
        else
        {
            currWaypoint++;

            
        }
       
     }
}
