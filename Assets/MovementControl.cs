using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovementControl : MonoBehaviour
{
	public float speed = 4f; //base speed
	public float TimeMove;
	public float damping = 3f; //how much the momentum transfer is damped
	
	public GameObject body;
	public Vector3 movement;
	public Vector3 rotation;
	public Rigidbody rigidBody;
	public new Camera camera;
	
	public Transform ground;
	public float groundGap = 0.2f;
	public LayerMask groundMask;
	public bool onGround;
	
    public bool jump;

    public float timer;
    float oldX;
    public float jumpTimer;
    public float jumpMax;

	
	public float mouseSens = 50f;
	float xRot = 0f;

	public bool OnVehicle;
	public GameObject Vehicle;
	private Vector3 VehiclePreviousLocation;
	private Quaternion VehiclePreviousRotation;
	public bool OnVehicleUpdateRotation;



	// Start is called before the first frame update
	void Start()
    {
		Cursor.lockState = CursorLockMode.Locked; //locks cursor to center, hides it i think
		
		rotation = Vector3.zero;
        timer = 0;
        oldX = 0;
        jump = false;
        jumpTimer = 0;
        jumpMax = 0.25f;

		OnVehicle = false;
		VehiclePreviousLocation = Vehicle.transform.position;
		OnVehicleUpdateRotation = false;
	}

	private void FixedUpdate()
	{
		VehicleMove();
	}

	void Update()
	{
        float mouseX = Input.GetAxis("Mouse X") * mouseSens * Time.deltaTime; 
		float mouseY = Input.GetAxis("Mouse Y") * mouseSens * Time.deltaTime;
		//get max rotation * sensitivity * how much time has passed
		
		xRot -= mouseY; //unity be backwards
		xRot = Mathf.Clamp(xRot, -85f, 90f); //so you cant invert camera
		
		camera.transform.localRotation = Quaternion.Euler(xRot, 0f, 0f); //up down rotation, with clamp
		body.transform.Rotate(Vector3.up * mouseX); //left right rotation, no clamp
		
		
		//jump logic
		jump = Input.GetAxis("Jump") != 0 ? true : false;
		
		
        if (jump && onGround) 
		{
			Vector3 jumpPower = new Vector3(0.0f, 2.0f, 0.0f);
			
			rigidBody.AddForce(jumpPower * 70f);
			onGround = false;
		}
		
		StartCoroutine(Move());
		
    }
	
	void OnCollisionStay()
	{
		onGround = true;
	}
	
	private void RotateCamera()
	{
		//camera rotate
		rotation = new Vector3(-Input.GetAxis("Mouse Y"), Input.GetAxis("Mouse X"), 0) * 3;
		Vector3 cameraDirection = this.camera.transform.rotation.eulerAngles;
		float cameraRotationX = cameraDirection.x + rotation.x; // Camera rotation

		float deadzone = 5; // deadzone is 5 degrees
		if ((cameraRotationX > 270 + deadzone && cameraRotationX < 360) || (cameraRotationX > 0 && cameraRotationX < 90 - deadzone)) { // in range
			oldX = cameraRotationX;
		}
		if (cameraRotationX < 270 + deadzone && cameraRotationX > 90 - deadzone) { // out of range
			cameraRotationX = oldX;
		}
		this.camera.transform.eulerAngles = new Vector3(cameraRotationX, this.camera.transform.eulerAngles.y, this.camera.transform.eulerAngles.z);
		//Debug.Log("cameraRotationX: " + cameraRotationX);
		//Debug.Log("x: " + rotation.x + " y: " + rotation.y + " z: " + rotation.z);
		//Debug.Log("x: " + cameraDirection.x + " y: " + cameraDirection.y + " z: " + cameraDirection.z);
	}
	
	IEnumerator Move()
	{
		float x = Input.GetAxis("Horizontal");
		float z = Input.GetAxis("Vertical");
		float bounce = 0.0f;
		float launchPower = 0.0f;
		
		Vector3 move = new Vector3(0, 0, 0);
		Vector3 slide = new Vector3(0, 0, 0);
		
		//debug
		Debug.DrawLine(this.transform.position, this.transform.position + this.camera.transform.forward * 3, Color.magenta);
		Debug.DrawLine(this.body.transform.position, this.body.transform.position + this.body.transform.forward * 3, Color.yellow);
		
		//body rotate and move
		this.body.transform.eulerAngles += new Vector3(0, rotation.y, 0); // turn left/right
		move = new Vector3(x * Time.deltaTime * speed, 0, z * Time.deltaTime * speed/3); 
		transform.Translate(x * Time.deltaTime * speed, 0, 0);
		transform.Translate(0, 0, z * Time.deltaTime * speed);
		
		yield return null;
	}

	void VehicleMove()
	{
		if (OnVehicle) //If on moving vehicle update transform according to vehicle displacement.. 
		{
			Vector3 difference = Vehicle.transform.position - VehiclePreviousLocation;
			float angleDifference = Vehicle.transform.rotation.eulerAngles.y - VehiclePreviousRotation.eulerAngles.y;

			transform.position = transform.position + difference;

			//Updating the moving vehicle change in rotation orientation will cause motion sickness. Can be lessen by decreaseing vehicle rotation speed or increaseing vehicle rotation. 
			if (OnVehicleUpdateRotation)
			{
				transform.localEulerAngles = new Vector3(transform.localEulerAngles.x, transform.localEulerAngles.y + angleDifference, transform.localEulerAngles.z);
			}

			VehiclePreviousLocation = Vehicle.transform.position;
			VehiclePreviousRotation = Vehicle.transform.rotation;
		}
	}
}
