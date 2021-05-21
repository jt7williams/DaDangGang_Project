using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;


public class ZombieControl : MonoBehaviour
{
	
	public NavMeshAgent agent;
	public Transform player;
	public LayerMask isGround, isPlayer;
	
	//states
	public float moveRange, meleeRange;
	public bool playerIsVisible, playerIsTarget;
	
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
    }
	
	private void Spawn()
	{
		player = GameObject.Find("Player").transform;
		agent = GetComponent<NavMeshAgent>();
		//play spawn animation
		//set initial head rotation
		initialRot = torso.transform.rotation;
		
	}
	
	private void Update()
	{
		playerIsVisible = Physics.CheckSphere(transform.position, moveRange, isPlayer);
		playerIsTarget = Physics.CheckSphere(transform.position, meleeRange, isPlayer);
		
		
		movementControl =  Rig.GetComponent<Animator>();
		
		if (!playerIsVisible && !playerIsTarget)
		{
			Patrol();
			TorsoLook();
		}
		if (playerIsVisible && !playerIsTarget)
		{
			Pursue();
			TorsoLook();

			movementControl.SetFloat("speed", Random.Range(0.7f, 1.3f));
			movementControl.SetFloat("attack", 0.0f);
		}
		if (playerIsVisible && playerIsTarget)
		{
			Attack();
			TorsoLook();
			Debug.Log("attack");
			movementControl.SetFloat("speed", Random.Range(0.8f, 1.4f));
			movementControl.SetFloat("attack", 2.0f);
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
			//agent.SetDestination(walkTo);
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
		//play lookat animation upper torso
		attackMode = true;
		agent.SetDestination(player.position);
		//Debug.Log(player.position);
	}
	
	private void BeginAttack()
	{
		agent.SetDestination(transform.position);
		//yield return new WaitForSeconds(1);
		//play attackstart animation
		Attack();
		TorsoLook();
		
	}
	
	
	private void Attack()
	{
		//player = GameObject.Find("Player").transform;
		agent.SetDestination(player.position);

		//play animation
		if (!hasAttacked)
		{
			hasAttacked = true;
			Invoke(nameof(EndAttack), attackDebounce);
		}
	}
	
	private void EndAttack()
	{
		hasAttacked = false;
	}
	
	private void TorsoLook()
	{
		player = GameObject.Find("Player").transform;
		Quaternion lookRot = Quaternion.LookRotation(player.position - torso.transform.position);
		torso.transform.rotation = lookRot;
	}
	
}