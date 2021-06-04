using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnZombies : MonoBehaviour
{
    public GameObject Player;
	public GameObject Zombie;
	public GameObject spawner;
	public int xPos;
	public int zPos;
	public float yPos;
	
	public int zombieCount;
	public int goalZombieCount;
	
	int timer;
	
    void Start()
    {
        StartCoroutine(ZombieSpawning());
    }


	IEnumerator ZombieSpawning()
	{
		yield return new WaitForSeconds(6.0f);
		while (true)
		{
			if (goalZombieCount == 0)
			{
				goalZombieCount = 3;
			}
			StartCoroutine(SpawnZombie());
			if (timer % 13 == 0)
			{
				goalZombieCount = goalZombieCount + 4;
			}
			timer = timer + 1;
			yield return new WaitForSeconds(3.0f);
		}
	}
	
	IEnumerator SpawnZombie()
	{
		zombieCount = 0;
		while (zombieCount <= goalZombieCount) //<= goalZombieCount
		{
			zombieCount = spawner.transform.childCount - 2;
			
			if (zombieCount < 35)
			{
				yield return new WaitForSeconds(Random.Range(0.2f, 0.6f));
				xPos = Random.Range(-10, 10);
				zPos = Random.Range(0, 40);
				yPos = Player.transform.position.y;
				GameObject newZombie = Instantiate(Zombie, new Vector3(Player.transform.position.x + xPos, (int)yPos, Player.transform.position.z + zPos), Quaternion.identity);
				newZombie.SetActive(true);
				newZombie.transform.SetParent(spawner.transform, true);
			}
			yield return new WaitForSeconds(0.2f);
		}
	}
	
    void Update()
    {
		
    }
}
