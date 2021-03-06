﻿using System.Collections.Generic;
namespace FileSharing.Persistence.Models
{
	public class Group : AbstractModel
	{
		public Group()
		{
            Files = new HashSet<File>();
			Users = new HashSet<UserGroup>();
		}

		public long Id { get; set; }
		public string Name { get; set; }
		public long IdAdmin { get; set; }

		public virtual ICollection<File> Files { get; set; }
		public virtual ICollection<UserGroup> Users { get; set; }
		public virtual User Admin { get; set; }

        public override string ToString()
        {
            string result = "";

            result += "Name: " + Name + "\r\n";
            result += "IdAdmin: " + IdAdmin;

            return result;
        }
    }
}
