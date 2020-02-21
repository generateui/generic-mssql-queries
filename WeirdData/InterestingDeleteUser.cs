/* SNIP */

namespace Parkmobile.Business.ServiceBlock.AccountService
{
    public class AccountManagement
    {
        /* SNIP */

        /// <summary>
        /// Removes the user account.
        /// </summary>
        /// <param name="userId">User id.</param>
        public void RemoveUserAccount(int userId)
        {
            /* SNIP */

            try
            {
                (new UserController()).RemoveUser(userId, RoleChecker.CurrentUser.UserID);
            }
            catch
            {
            }

            user = GetUser(userId);
            if (user != null && !user.Deleted)
            {
                //deletion failed
                user.Deleted = true;
                user.DeletionDate = DateTime.UtcNow;
                user.Enabled = false;
                user.MobileNumber = "del " + user.MobileNumber;
                user.UserName = "del " + user.UserName;
                user.Password = "";
                user.PinCode = "";

                // in NL this field is INITIALS
                var uc = new UserController();
                if (!String.IsNullOrEmpty(user.FirstName))
                    user.FirstName = Thread.CurrentThread.CurrentCulture.Name.ToLower() == "nl-nl" ? user.FirstName.ToUpper() : user.FirstName.RightCasing();
                //do not audit this: its already been marked for deletion
                uc.SaveUser(ref user);
            }
        }
    }
}