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

	public GameObject player;
	public GameObject vrCam;
    public GameObject kbmCam;
    public bool canMove = true;

    public WheelCollider[] wheels;
    private float turnSpeed = 30;

	public Animator VehicleAnim1;
	public Animator VehicleAnim2;
	public Animator VehicleAnim3;
	public Animator VehicleAnim4;

    // Start is called before the first frame update
    void Start()
    {
		//player select;
		if (StateNameController.camNumber == 1)
        {
            player = vrCam;
        }
        else if (StateNameController.camNumber == 2)
        {
            player = kbmCam;
        }
		else 
		{
			player = kbmCam;
		}
		
        //Alighn the game objecst so they look at the next;
        for (int cnt = 0; cnt < waypoints.Length - 1; cnt++)
        {
            Vector3 pos = waypoints[cnt].transform.position;
            waypoints[cnt].transform.LookAt(waypoints[cnt + 1].transform.position);
            pos.y = Terrain.activeTerrain.SampleHeight(waypoints[cnt].transform.position) + 3.8f;
            waypoints[cnt].transform.position = pos;

        }
        Vector3 poslast = waypoints[waypoints.Length - 1].transform.position;
        poslast.y = Terrain.activeTerrain.SampleHeight(waypoints[waypoints.Length - 1].transform.position) + 3.8f;
        waypoints[waypoints.Length - 1].transform.position = poslast;
        currWaypoint = 0;

        //speed = 10f;

        rb = GetComponent<Rigidbody>();
        for (int i = 0; i < 4; ++i)
        {
            wheels[i].brakeTorque = 5000F;
            wheels[i].motorTorque = 15000f;
        }

    }

    void Update() 
	{
        
    }
    void FixedUpdate()
    {
		//bool canMove = true;
        /*
		//player distance check
		float distance = Vector3.Distance (player.transform.position, this.transform.position);
		if (distance > 14)
		{
			canMove = false;
			VehicleAnim1.SetBool("Moving", false);
			VehicleAnim2.SetBool("Moving", false);
			VehicleAnim3.SetBool("Moving", false);
			VehicleAnim4.SetBool("Moving", false);
		}
		if (distance <= 14)
		{
			canMove = true;
			VehicleAnim1.SetBool("Moving", true);
			VehicleAnim2.SetBool("Moving", true);
			VehicleAnim3.SetBool("Moving", true);
			VehicleAnim4.SetBool("Moving", true);
		}*/
		//Debug.Log(distance);
		
		if (canMove)
		{
            for (int i = 0; i < 4; ++i)
            {
                //wheels[i].brakeTorque = 5000F * 0.1F;
                wheels[i].motorTorque = 1000f;


            }

            //When the vehicle hits a steep incline then increase the speed by 5f. 
            if (transform.eulerAngles.x > 300f && transform.eulerAngles.x < 350f)
			{
				Debug.Log("increasing speed.\n");
				speed = VehicleSpeed + 10f;
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



    }

    void MoveVehicle(GameObject wpts){

        float distance = Vector3.Distance(transform.position, wpts.transform.position);
        Vector3 StraightPath = wpts.transform.position - transform.position;

        Vector3 PositionOffset = new Vector3(StraightPath.x, 0f, StraightPath.z);

        if (currWaypoint > 0)
        {
            wheels[1].steerAngle = Quaternion.RotateTowards(transform.rotation, waypoints[currWaypoint - 1].transform.rotation, turnSpeed).y;
            wheels[2].steerAngle = Quaternion.RotateTowards(transform.rotation, waypoints[currWaypoint - 1].transform.rotation, turnSpeed).y;
        }

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
        





        if (distance > 6f)
        {

            rb.MovePosition(rb.transform.position + PositionOffset.normalized * speed * Time.fixedDeltaTime);
            
            

        }
        else
        {
            currWaypoint++;

            
        }
       
     }
}
