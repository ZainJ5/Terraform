# 1. Create the Groups
resource "aws_iam_group" "admin" {
  name = "Admin-Group"
}

resource "aws_iam_group" "developers" {
  name = "Developer-Group"
}

resource "aws_iam_group" "qa" {
  name = "QA-Group"
}

# 2. Attach Appropriate Permissions to Groups
resource "aws_iam_group_policy_attachment" "admin_access" {
  group      = aws_iam_group.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "developer_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_group_policy_attachment" "qa_access" {
  group      = aws_iam_group.qa.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# 3. Create the Users
resource "aws_iam_user" "zain" {
  name = "zain.dev"
}

resource "aws_iam_user" "ali" {
  name = "ali.qa"
}

resource "aws_iam_user" "hamid" {
  name = "hamid.admin"
}

# 4. Add Users to their respective Groups
resource "aws_iam_user_group_membership" "zain_membership" {
  user   = aws_iam_user.zain.name
  groups = [aws_iam_group.developers.name]
}

resource "aws_iam_user_group_membership" "ali_membership" {
  user   = aws_iam_user.ali.name
  groups = [aws_iam_group.qa.name]
}

resource "aws_iam_user_group_membership" "hamid_membership" {
  user   = aws_iam_user.hamid.name
  groups = [aws_iam_group.admin.name]
}