using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;


public class ZombieControl : MonoBehaviour
{
	
	public NavMeshAgent agent;
	private Transform targetThis;
	private Transform player;
	
	private Transform targetCam;
	public Transform vehicle;
    //playerstats object to affect player health
    public playerStats target;
	public VehiclePresetPath spde;

    [SerializeField] float damage;
    float lastAttack = 0;
    float attackCooldown = 1.5f;


    public Transform vrCam;
    public Transform kbmCam;

    public LayerMask isGround, isPlayer;
	
	//states
	public float moveRange, meleeRange;
	public bool playerIsVisible, playerIsTarget;
	
	//ragdolllll
	public List<Collider> RagdollParts = new List<Collider>();
	Rigidbody[] rigids;
	
	//limb essentials
	public GameObject head;
	public bool isDead = false;
	public GameObject mainTarget;
	
	//animations
	public GameObject Rig;
	[SerializeField] Animator movementControl;
	//public Animation armWalk;
	[SerializeField, Range(0.01f, 2f)] float animateSpeed;
	
	//public animation WalkAnim;
	
	//roam
	public Vector3 walkTo;
	bool setWalkPoint;
	public float walkToRange;
	
	//attack
	public float attackDebounce;
	bool attackMode, hasAttacked;
	
	//zombie limbs
	public GameObject torso;
	private Quaternion initialRot;
	
    // Start is called before the first frame update
    void Start()
    {
		attackMode = false;
        if (StateNameController.camNumber == 1)
        {
			targetCam = vrCam;
        }
        else if (StateNameController.camNumber == 2)
        {
			targetCam = kbmCam;
        }
		else 
		{
			targetCam = kbmCam;
		}
        Spawn();
    }
	
	private void Spawn()
	{
		agent = GetComponent<NavMeshAgent>();
		initialRot = torso.transform.rotation;
		TurnOffRagdoll();
	}
	
	private void FixedUpdate()
	{
		playerIsVisible = Physics.CheckSphere(transform.position, moveRange, isPlayer);
		playerIsTarget = Physics.CheckSphere(transform.position, meleeRange, isPlayer);
		
		movementControl =  Rig.GetComponent<Animator>();
		if (mainTarget.GetComponent<zombieHealth>().mainhealth <= 0)
		{
			if (isDead == false)
			{
				isDead = true;
				movementControl.enabled = false;
				ActivateRagdoll();
				Destroy(this.gameObject, 6.0f);
			}
		}
		if ((head == null))// || 
		{
			//ragdolllll
			if (isDead == false)
			{
				isDead = true;
				movementControl.enabled = false;
				ActivateRagdoll();
				//kill momentum here
				Destroy(this.gameObject, 6.0f);
			}
		}
		
		if (isDead == false)
		{
			float vehicleDist = Vector3.Distance (transform.position, vehicle.position);
			float playerDist = Vector3.Distance (transform.position, targetCam.position);
			
			
			if (vehicleDist < playerDist)
			{
				player = vehicle;
			}
			else 
			{
				player = targetCam;
			}
			
			if (!playerIsVisible && !playerIsTarget)
			{
				//Debug.Log("not moving");
				agent.speed = 3.0f;
				movementControl.SetFloat("speed", Random.Range(0.3f, 0.5f));
				Patrol();
			}
			if (playerIsVisible && !playerIsTarget)
			{
				Pursue();
				//Debug.Log("moving");
				//TorsoLook();
				agent.speed = 4.5f;
				movementControl.SetFloat("speed", Random.Range(0.7f, 1.3f));
				movementControl.SetFloat("attack", 0.0f);
			}
			if (playerIsVisible && playerIsTarget)
			{
				Attack();
				//Debug.Log("attack");
				//TorsoLook();
				agent.speed = 6.0f;
				
			}
		}
		
	}
	
	private void Patrol()
	{
		if (!setWalkPoint)
		{
			FindWalkLocation();
		}
		else if(!attackMode)
		{
			agent.SetDestination(walkTo);
		}
		
		Vector3 targetDistance = transform.position - walkTo;
		
		if ( (targetDistance.magnitude < 1f) || (attackMode) )
		{
			setWalkPoint = false;
		}
	}
	
	private void FindWalkLocation()
	{
		float randomRangeX = Random.Range(-walkToRange, walkToRange);
		float randomRangeZ = Random.Range(-walkToRange, walkToRange);
		
		walkTo = new Vector3(transform.position.x + randomRangeX, transform.position.y, transform.position.z + randomRangeZ);
		
		if (Physics.Raycast(walkTo, -transform.up, 2f, isGround))
		{
			setWalkPoint = true;
		}
	}
	
	private void Pursue()
	{
		attackMode = true;
		agent.SetDestination(player.position);
		TorsoLook();
	}
	
	private void BeginAttack()
	{
		Attack();
		TorsoLook();
	}
	
	private void Attack()
	{
		if (!hasAttacked && Time.time - lastAttack >= attackCooldown)
		{
			hasAttacked = true;
			lastAttack = Time.time;
			StartCoroutine(ProcessAttack());
			Invoke(nameof(EndAttack), attackDebounce);
		}
	}
	
	IEnumerator ProcessAttack()
	{
		movementControl.SetFloat("speed", Random.Range(1.1f, 1.45f));
		movementControl.SetFloat("attack", 2.0f);
		yield return new WaitForSeconds(0.25f);


		
		float vehicleDist = Vector3.Distance (transform.position, vehicle.position);
		float playerDist = Vector3.Distance (transform.position, targetCam.position);
		
		
		if (vehicleDist < playerDist)
		{
			target.takeTankDmg(2f);
			//spde.VehicleSpeed = -1;
		}
		else 
		{
			target.takePlayerDMG(2f);
		}
		
		
	}
	
	private void EndAttack()
	{
		hasAttacked = false;
	}
	
	private void TorsoLook()
	{
		Quaternion lookRot = Quaternion.LookRotation(player.position - torso.transform.position);
		transform.rotation = lookRot;
	}
	
	private void TurnOffRagdoll()
	{
		foreach (Collider c in RagdollParts)
		{
			//c.isTrigger = true;
		}
	}
	
	private void ActivateRagdoll()
	{
		//CapsuleCollider[] cols = GetComponentsInChildren<CapsuleCollider>();
		
		/*
		foreach (Collider c in RagdollParts)
		{
			c.isTrigger = false;
			//c.attachedRigidbody.WakeUp();
			//c.attachedRigidbody.detectCollisions = true;
		}
		*/
		
		/*
		foreach (Rigidbody r in rigids)
		{
			r.WakeUp();
			//r.isKinematic = true;
		}
		*/

	}
	
}
