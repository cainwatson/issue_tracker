import gql from 'graphql-tag';
import * as VueApolloComposable from '@vue/apollo-composable';
import * as VueCompositionApi from 'vue';
export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type ReactiveFunction<TParam> = () => TParam;
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  /** An ISO 8601-encoded datetime */
  ISO8601DateTime: any;
};

export type Board = Node & {
  __typename?: 'Board';
  columns: Array<BoardColumn>;
  createdAt: Scalars['ISO8601DateTime'];
  id: Scalars['ID'];
  name: Scalars['String'];
  project: Project;
  updatedAt: Scalars['ISO8601DateTime'];
  userCreator: User;
};

export type BoardColumn = Node & {
  __typename?: 'BoardColumn';
  board: Board;
  boardPosition: Scalars['Int'];
  createdAt: Scalars['ISO8601DateTime'];
  id: Scalars['ID'];
  items: Array<BoardItem>;
  name: Scalars['String'];
  updatedAt: Scalars['ISO8601DateTime'];
  userCreator: User;
};

export type BoardItem = Node & {
  __typename?: 'BoardItem';
  board: Board;
  column?: Maybe<BoardColumn>;
  columnPosition: Scalars['Int'];
  createdAt: Scalars['ISO8601DateTime'];
  id: Scalars['ID'];
  issue?: Maybe<Issue>;
  updatedAt: Scalars['ISO8601DateTime'];
  userCreator: User;
};

/** Autogenerated input type of CreateBoardColumn */
export type CreateBoardColumnInput = {
  userCreatorId: Scalars['ID'];
  boardId: Scalars['ID'];
  name: Scalars['String'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of CreateBoardColumn */
export type CreateBoardColumnPayload = {
  __typename?: 'CreateBoardColumnPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  column?: Maybe<BoardColumn>;
  errors?: Maybe<Array<Scalars['String']>>;
};

/** Autogenerated input type of CreateBoard */
export type CreateBoardInput = {
  userCreatorId: Scalars['ID'];
  projectId: Scalars['ID'];
  name: Scalars['String'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated input type of CreateBoardItem */
export type CreateBoardItemInput = {
  userCreatorId: Scalars['ID'];
  boardId: Scalars['ID'];
  columnId?: Maybe<Scalars['ID']>;
  issueId?: Maybe<Scalars['ID']>;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of CreateBoardItem */
export type CreateBoardItemPayload = {
  __typename?: 'CreateBoardItemPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  item?: Maybe<BoardItem>;
};

/** Autogenerated return type of CreateBoard */
export type CreateBoardPayload = {
  __typename?: 'CreateBoardPayload';
  board?: Maybe<Board>;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
};

/** Autogenerated input type of CreateIssue */
export type CreateIssueInput = {
  userCreatorId: Scalars['ID'];
  projectId: Scalars['ID'];
  boardIds?: Maybe<Array<Scalars['ID']>>;
  summary: Scalars['String'];
  description?: Maybe<Scalars['String']>;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of CreateIssue */
export type CreateIssuePayload = {
  __typename?: 'CreateIssuePayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  issue?: Maybe<Issue>;
};

/** Autogenerated input type of CreateOrganization */
export type CreateOrganizationInput = {
  userCreatorId: Scalars['ID'];
  name: Scalars['String'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of CreateOrganization */
export type CreateOrganizationPayload = {
  __typename?: 'CreateOrganizationPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  organization?: Maybe<Organization>;
};

/** Autogenerated input type of CreateProject */
export type CreateProjectInput = {
  userCreatorId: Scalars['ID'];
  ownerId: Scalars['ID'];
  ownerType: ProjectOwnerCategory;
  name: Scalars['String'];
  photoUrl?: Maybe<Scalars['String']>;
  isPrivate?: Maybe<Scalars['Boolean']>;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of CreateProject */
export type CreateProjectPayload = {
  __typename?: 'CreateProjectPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  project?: Maybe<Project>;
};


/** Autogenerated input type of InviteMember */
export type InviteMemberInput = {
  organizationId: Scalars['String'];
  userFromId: Scalars['ID'];
  userToId: Scalars['ID'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of InviteMember */
export type InviteMemberPayload = {
  __typename?: 'InviteMemberPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  membership?: Maybe<Membership>;
};

export type Issue = Node & {
  __typename?: 'Issue';
  boardItems: Array<BoardItem>;
  createdAt: Scalars['ISO8601DateTime'];
  description: Scalars['String'];
  id: Scalars['ID'];
  number: Scalars['Int'];
  project: Project;
  summary: Scalars['String'];
  updatedAt: Scalars['ISO8601DateTime'];
  userCreator: User;
};

export type Membership = Node & {
  __typename?: 'Membership';
  createdAt: Scalars['ISO8601DateTime'];
  id: Scalars['ID'];
  organization: Organization;
  updatedAt: Scalars['ISO8601DateTime'];
  userFrom: User;
  userTo: User;
};

/** Autogenerated input type of MoveBoardColumn */
export type MoveBoardColumnInput = {
  columnId: Scalars['ID'];
  position: Scalars['Int'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of MoveBoardColumn */
export type MoveBoardColumnPayload = {
  __typename?: 'MoveBoardColumnPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  column?: Maybe<BoardColumn>;
  errors?: Maybe<Array<Scalars['String']>>;
};

/** Autogenerated input type of MoveBoardItem */
export type MoveBoardItemInput = {
  itemId: Scalars['ID'];
  position: Scalars['Int'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of MoveBoardItem */
export type MoveBoardItemPayload = {
  __typename?: 'MoveBoardItemPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  item?: Maybe<BoardItem>;
};

export type Mutation = {
  __typename?: 'Mutation';
  /** Create a new project board. */
  createBoard?: Maybe<CreateBoardPayload>;
  /** Create a new column on a project board. */
  createBoardColumn?: Maybe<CreateBoardColumnPayload>;
  /** Create a new item on a project board. */
  createBoardItem?: Maybe<CreateBoardItemPayload>;
  /** Create a new issue. */
  createIssue?: Maybe<CreateIssuePayload>;
  /** Create a new organization. */
  createOrganization?: Maybe<CreateOrganizationPayload>;
  /** Create a new project. */
  createProject?: Maybe<CreateProjectPayload>;
  /** Invite a user to an organization. */
  inviteMember?: Maybe<InviteMemberPayload>;
  /** Move a column on a board to a new position. */
  moveBoardColumn?: Maybe<MoveBoardColumnPayload>;
  /** Move an item in a column to a new position. */
  moveBoardItem?: Maybe<MoveBoardItemPayload>;
  /** Return user with matching credentials. */
  passwordSignIn?: Maybe<PasswordSignInPayload>;
  /** Remove a user from an organization. */
  removeMember?: Maybe<RemoveMemberPayload>;
  /** Create a new user account. */
  signUp?: Maybe<SignUpPayload>;
  /** Return user with JWT token. */
  tokenSignIn?: Maybe<TokenSignInPayload>;
  /** Update an issue. */
  updateIssue?: Maybe<UpdateIssuePayload>;
  /** Update an organization. */
  updateOrganization?: Maybe<UpdateOrganizationPayload>;
};


export type MutationCreateBoardArgs = {
  input: CreateBoardInput;
};


export type MutationCreateBoardColumnArgs = {
  input: CreateBoardColumnInput;
};


export type MutationCreateBoardItemArgs = {
  input: CreateBoardItemInput;
};


export type MutationCreateIssueArgs = {
  input: CreateIssueInput;
};


export type MutationCreateOrganizationArgs = {
  input: CreateOrganizationInput;
};


export type MutationCreateProjectArgs = {
  input: CreateProjectInput;
};


export type MutationInviteMemberArgs = {
  input: InviteMemberInput;
};


export type MutationMoveBoardColumnArgs = {
  input: MoveBoardColumnInput;
};


export type MutationMoveBoardItemArgs = {
  input: MoveBoardItemInput;
};


export type MutationPasswordSignInArgs = {
  input: PasswordSignInInput;
};


export type MutationRemoveMemberArgs = {
  input: RemoveMemberInput;
};


export type MutationSignUpArgs = {
  input: SignUpInput;
};


export type MutationTokenSignInArgs = {
  input: TokenSignInInput;
};


export type MutationUpdateIssueArgs = {
  input: UpdateIssueInput;
};


export type MutationUpdateOrganizationArgs = {
  input: UpdateOrganizationInput;
};

/** An object with an ID. */
export type Node = {
  /** ID of the object. */
  id: Scalars['ID'];
};

export type Organization = Node & {
  __typename?: 'Organization';
  createdAt: Scalars['ISO8601DateTime'];
  id: Scalars['ID'];
  memberships: Array<Membership>;
  name: Scalars['String'];
  photoUrl?: Maybe<Scalars['String']>;
  projects: Array<Project>;
  updatedAt: Scalars['ISO8601DateTime'];
  userCreator: User;
};

/** Autogenerated input type of PasswordSignIn */
export type PasswordSignInInput = {
  email: Scalars['String'];
  password: Scalars['String'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of PasswordSignIn */
export type PasswordSignInPayload = {
  __typename?: 'PasswordSignInPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  token?: Maybe<Scalars['String']>;
  user?: Maybe<User>;
};

export type Profile = Node & {
  __typename?: 'Profile';
  createdAt: Scalars['ISO8601DateTime'];
  firstName: Scalars['String'];
  id: Scalars['ID'];
  lastName?: Maybe<Scalars['String']>;
  photoUrl?: Maybe<Scalars['String']>;
  updatedAt: Scalars['ISO8601DateTime'];
  user: User;
};

export type Project = Node & {
  __typename?: 'Project';
  boards: Array<Board>;
  createdAt: Scalars['ISO8601DateTime'];
  id: Scalars['ID'];
  isPrivate: Scalars['Boolean'];
  issues: Array<Issue>;
  name: Scalars['String'];
  owner: ProjectOwner;
  ownerType: ProjectOwnerCategory;
  photoUrl?: Maybe<Scalars['String']>;
  updatedAt: Scalars['ISO8601DateTime'];
  userCreator: User;
};

/** An owner of a project. */
export type ProjectOwner = Organization | User;

export enum ProjectOwnerCategory {
  /** A project owned by a user account. */
  Account = 'ACCOUNT',
  /** A project owned by an organization. */
  Organization = 'ORGANIZATION'
}

export type Query = {
  __typename?: 'Query';
  /** Fetches an object given its ID. */
  node?: Maybe<Node>;
  /** Fetches a list of objects given a list of IDs. */
  nodes: Array<Maybe<Node>>;
  users: Array<User>;
};


export type QueryNodeArgs = {
  id: Scalars['ID'];
};


export type QueryNodesArgs = {
  ids: Array<Scalars['ID']>;
};

/** Autogenerated input type of RemoveMember */
export type RemoveMemberInput = {
  organizationId: Scalars['ID'];
  userId: Scalars['ID'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of RemoveMember */
export type RemoveMemberPayload = {
  __typename?: 'RemoveMemberPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  membership?: Maybe<Membership>;
};

/** Autogenerated input type of SignUp */
export type SignUpInput = {
  email: Scalars['String'];
  password: Scalars['String'];
  firstName: Scalars['String'];
  lastName?: Maybe<Scalars['String']>;
  photoUrl?: Maybe<Scalars['String']>;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of SignUp */
export type SignUpPayload = {
  __typename?: 'SignUpPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  token?: Maybe<Scalars['String']>;
  user?: Maybe<User>;
};

/** Autogenerated input type of TokenSignIn */
export type TokenSignInInput = {
  token: Scalars['String'];
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of TokenSignIn */
export type TokenSignInPayload = {
  __typename?: 'TokenSignInPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  token?: Maybe<Scalars['String']>;
  user?: Maybe<User>;
};

/** Autogenerated input type of UpdateIssue */
export type UpdateIssueInput = {
  issueId: Scalars['ID'];
  summary?: Maybe<Scalars['String']>;
  description?: Maybe<Scalars['String']>;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of UpdateIssue */
export type UpdateIssuePayload = {
  __typename?: 'UpdateIssuePayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  issue?: Maybe<Issue>;
};

/** Autogenerated input type of UpdateOrganization */
export type UpdateOrganizationInput = {
  organizationId: Scalars['ID'];
  name?: Maybe<Scalars['String']>;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
};

/** Autogenerated return type of UpdateOrganization */
export type UpdateOrganizationPayload = {
  __typename?: 'UpdateOrganizationPayload';
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']>;
  errors?: Maybe<Array<Scalars['String']>>;
  organization?: Maybe<Organization>;
};

export type User = Node & {
  __typename?: 'User';
  createdAt: Scalars['ISO8601DateTime'];
  email: Scalars['String'];
  id: Scalars['ID'];
  memberships: Array<Membership>;
  profile: Profile;
  projects: Array<Project>;
  updatedAt: Scalars['ISO8601DateTime'];
};

export type PasswordSignInMutationVariables = Exact<{
  fields: PasswordSignInInput;
}>;


export type PasswordSignInMutation = (
  { __typename?: 'Mutation' }
  & { passwordSignIn?: Maybe<(
    { __typename?: 'PasswordSignInPayload' }
    & Pick<PasswordSignInPayload, 'errors' | 'token'>
    & { user?: Maybe<(
      { __typename?: 'User' }
      & Pick<User, 'id' | 'createdAt' | 'updatedAt' | 'email'>
    )> }
  )> }
);

export type SignUpMutationVariables = Exact<{
  fields: SignUpInput;
}>;


export type SignUpMutation = (
  { __typename?: 'Mutation' }
  & { signUp?: Maybe<(
    { __typename?: 'SignUpPayload' }
    & Pick<SignUpPayload, 'errors' | 'token'>
    & { user?: Maybe<(
      { __typename?: 'User' }
      & Pick<User, 'id' | 'createdAt' | 'updatedAt' | 'email'>
    )> }
  )> }
);

export type TokenSignInMutationVariables = Exact<{
  fields: TokenSignInInput;
}>;


export type TokenSignInMutation = (
  { __typename?: 'Mutation' }
  & { tokenSignIn?: Maybe<(
    { __typename?: 'TokenSignInPayload' }
    & Pick<TokenSignInPayload, 'errors' | 'token'>
    & { user?: Maybe<(
      { __typename?: 'User' }
      & Pick<User, 'id' | 'createdAt' | 'updatedAt' | 'email'>
    )> }
  )> }
);

export type GetOrganizationQueryVariables = Exact<{
  organizationId: Scalars['ID'];
}>;


export type GetOrganizationQuery = (
  { __typename?: 'Query' }
  & { node?: Maybe<{ __typename?: 'Board' } | { __typename?: 'BoardColumn' } | { __typename?: 'BoardItem' } | { __typename?: 'Issue' } | { __typename?: 'Membership' } | (
    { __typename?: 'Organization' }
    & Pick<Organization, 'id' | 'createdAt' | 'updatedAt' | 'name' | 'photoUrl'>
  ) | { __typename?: 'Profile' } | { __typename?: 'Project' } | { __typename?: 'User' }> }
);

export type GetProjectQueryVariables = Exact<{
  projectId: Scalars['ID'];
}>;


export type GetProjectQuery = (
  { __typename?: 'Query' }
  & { node?: Maybe<{ __typename?: 'Board' } | { __typename?: 'BoardColumn' } | { __typename?: 'BoardItem' } | { __typename?: 'Issue' } | { __typename?: 'Membership' } | { __typename?: 'Organization' } | { __typename?: 'Profile' } | (
    { __typename?: 'Project' }
    & Pick<Project, 'id' | 'name'>
  ) | { __typename?: 'User' }> }
);

export type GetProjectBoardsQueryVariables = Exact<{
  projectId: Scalars['ID'];
}>;


export type GetProjectBoardsQuery = (
  { __typename?: 'Query' }
  & { node?: Maybe<{ __typename?: 'Board' } | { __typename?: 'BoardColumn' } | { __typename?: 'BoardItem' } | { __typename?: 'Issue' } | { __typename?: 'Membership' } | { __typename?: 'Organization' } | { __typename?: 'Profile' } | (
    { __typename?: 'Project' }
    & Pick<Project, 'id'>
    & { boards: Array<(
      { __typename?: 'Board' }
      & Pick<Board, 'id' | 'createdAt' | 'updatedAt' | 'name'>
    )> }
  ) | { __typename?: 'User' }> }
);

export type GetProjectIssuesQueryVariables = Exact<{
  projectId: Scalars['ID'];
}>;


export type GetProjectIssuesQuery = (
  { __typename?: 'Query' }
  & { node?: Maybe<{ __typename?: 'Board' } | { __typename?: 'BoardColumn' } | { __typename?: 'BoardItem' } | { __typename?: 'Issue' } | { __typename?: 'Membership' } | { __typename?: 'Organization' } | { __typename?: 'Profile' } | (
    { __typename?: 'Project' }
    & Pick<Project, 'id'>
    & { issues: Array<(
      { __typename?: 'Issue' }
      & Pick<Issue, 'id' | 'createdAt' | 'updatedAt' | 'summary' | 'description' | 'number'>
    )> }
  ) | { __typename?: 'User' }> }
);

export type UserOrganizationsQueryVariables = Exact<{
  userId: Scalars['ID'];
}>;


export type UserOrganizationsQuery = (
  { __typename?: 'Query' }
  & { node?: Maybe<{ __typename?: 'Board' } | { __typename?: 'BoardColumn' } | { __typename?: 'BoardItem' } | { __typename?: 'Issue' } | { __typename?: 'Membership' } | { __typename?: 'Organization' } | { __typename?: 'Profile' } | { __typename?: 'Project' } | (
    { __typename?: 'User' }
    & { memberships: Array<(
      { __typename?: 'Membership' }
      & Pick<Membership, 'id' | 'createdAt' | 'updatedAt'>
      & { userFrom: (
        { __typename?: 'User' }
        & Pick<User, 'id'>
      ), userTo: (
        { __typename?: 'User' }
        & Pick<User, 'id'>
      ), organization: (
        { __typename?: 'Organization' }
        & Pick<Organization, 'id' | 'createdAt' | 'updatedAt' | 'name' | 'photoUrl'>
      ) }
    )> }
  )> }
);

export type UserProjectsQueryVariables = Exact<{
  userId: Scalars['ID'];
}>;


export type UserProjectsQuery = (
  { __typename?: 'Query' }
  & { node?: Maybe<{ __typename?: 'Board' } | { __typename?: 'BoardColumn' } | { __typename?: 'BoardItem' } | { __typename?: 'Issue' } | { __typename?: 'Membership' } | { __typename?: 'Organization' } | { __typename?: 'Profile' } | { __typename?: 'Project' } | (
    { __typename?: 'User' }
    & { projects: Array<(
      { __typename?: 'Project' }
      & Pick<Project, 'id' | 'name'>
    )> }
  )> }
);


export const PasswordSignInDocument = gql`
    mutation passwordSignIn($fields: PasswordSignInInput!) {
  passwordSignIn(input: $fields) {
    errors
    token
    user {
      id
      createdAt
      updatedAt
      email
    }
  }
}
    `;

/**
 * __usePasswordSignInMutation__
 *
 * To run a mutation, you first call `usePasswordSignInMutation` within a Vue component and pass it any options that fit your needs.
 * When your component renders, `usePasswordSignInMutation` returns an object that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - Several other properties: https://v4.apollo.vuejs.org/api/use-mutation.html#return
 *
 * @param options that will be passed into the mutation, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/mutation.html#options;
 *
 * @example
 * const { mutate, loading, error, onDone } = usePasswordSignInMutation({
 *   variables: {
 *      fields: // value for 'fields'
 *   },
 * });
 */
export function usePasswordSignInMutation(options: VueApolloComposable.UseMutationOptions<PasswordSignInMutation, PasswordSignInMutationVariables> | ReactiveFunction<VueApolloComposable.UseMutationOptions<PasswordSignInMutation, PasswordSignInMutationVariables>>) {
            return VueApolloComposable.useMutation<PasswordSignInMutation, PasswordSignInMutationVariables>(PasswordSignInDocument, options);
          }
export type PasswordSignInMutationCompositionFunctionResult = VueApolloComposable.UseMutationReturn<PasswordSignInMutation, PasswordSignInMutationVariables>;
export const SignUpDocument = gql`
    mutation signUp($fields: SignUpInput!) {
  signUp(input: $fields) {
    errors
    token
    user {
      id
      createdAt
      updatedAt
      email
    }
  }
}
    `;

/**
 * __useSignUpMutation__
 *
 * To run a mutation, you first call `useSignUpMutation` within a Vue component and pass it any options that fit your needs.
 * When your component renders, `useSignUpMutation` returns an object that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - Several other properties: https://v4.apollo.vuejs.org/api/use-mutation.html#return
 *
 * @param options that will be passed into the mutation, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/mutation.html#options;
 *
 * @example
 * const { mutate, loading, error, onDone } = useSignUpMutation({
 *   variables: {
 *      fields: // value for 'fields'
 *   },
 * });
 */
export function useSignUpMutation(options: VueApolloComposable.UseMutationOptions<SignUpMutation, SignUpMutationVariables> | ReactiveFunction<VueApolloComposable.UseMutationOptions<SignUpMutation, SignUpMutationVariables>>) {
            return VueApolloComposable.useMutation<SignUpMutation, SignUpMutationVariables>(SignUpDocument, options);
          }
export type SignUpMutationCompositionFunctionResult = VueApolloComposable.UseMutationReturn<SignUpMutation, SignUpMutationVariables>;
export const TokenSignInDocument = gql`
    mutation tokenSignIn($fields: TokenSignInInput!) {
  tokenSignIn(input: $fields) {
    errors
    token
    user {
      id
      createdAt
      updatedAt
      email
    }
  }
}
    `;

/**
 * __useTokenSignInMutation__
 *
 * To run a mutation, you first call `useTokenSignInMutation` within a Vue component and pass it any options that fit your needs.
 * When your component renders, `useTokenSignInMutation` returns an object that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - Several other properties: https://v4.apollo.vuejs.org/api/use-mutation.html#return
 *
 * @param options that will be passed into the mutation, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/mutation.html#options;
 *
 * @example
 * const { mutate, loading, error, onDone } = useTokenSignInMutation({
 *   variables: {
 *      fields: // value for 'fields'
 *   },
 * });
 */
export function useTokenSignInMutation(options: VueApolloComposable.UseMutationOptions<TokenSignInMutation, TokenSignInMutationVariables> | ReactiveFunction<VueApolloComposable.UseMutationOptions<TokenSignInMutation, TokenSignInMutationVariables>>) {
            return VueApolloComposable.useMutation<TokenSignInMutation, TokenSignInMutationVariables>(TokenSignInDocument, options);
          }
export type TokenSignInMutationCompositionFunctionResult = VueApolloComposable.UseMutationReturn<TokenSignInMutation, TokenSignInMutationVariables>;
export const GetOrganizationDocument = gql`
    query getOrganization($organizationId: ID!) {
  node(id: $organizationId) {
    ... on Organization {
      id
      createdAt
      updatedAt
      name
      photoUrl
    }
  }
}
    `;

/**
 * __useGetOrganizationQuery__
 *
 * To run a query within a Vue component, call `useGetOrganizationQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetOrganizationQuery` returns an object from Apollo Client that contains result, loading and error properties
 * you can use to render your UI.
 *
 * @param options that will be passed into the query, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/query.html#options;
 *
 * @example
 * const { result, loading, error } = useGetOrganizationQuery(
 *   {
 *      organizationId: // value for 'organizationId'
 *   }
 * );
 */
export function useGetOrganizationQuery(variables: GetOrganizationQueryVariables | VueCompositionApi.Ref<GetOrganizationQueryVariables> | ReactiveFunction<GetOrganizationQueryVariables>, options: VueApolloComposable.UseQueryOptions<GetOrganizationQuery, GetOrganizationQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<GetOrganizationQuery, GetOrganizationQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<GetOrganizationQuery, GetOrganizationQueryVariables>> = {}) {
            return VueApolloComposable.useQuery<GetOrganizationQuery, GetOrganizationQueryVariables>(GetOrganizationDocument, variables, options);
          }
export type GetOrganizationQueryCompositionFunctionResult = VueApolloComposable.UseQueryReturn<GetOrganizationQuery, GetOrganizationQueryVariables>;
export const GetProjectDocument = gql`
    query getProject($projectId: ID!) {
  node(id: $projectId) {
    ... on Project {
      id
      name
    }
  }
}
    `;

/**
 * __useGetProjectQuery__
 *
 * To run a query within a Vue component, call `useGetProjectQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetProjectQuery` returns an object from Apollo Client that contains result, loading and error properties
 * you can use to render your UI.
 *
 * @param options that will be passed into the query, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/query.html#options;
 *
 * @example
 * const { result, loading, error } = useGetProjectQuery(
 *   {
 *      projectId: // value for 'projectId'
 *   }
 * );
 */
export function useGetProjectQuery(variables: GetProjectQueryVariables | VueCompositionApi.Ref<GetProjectQueryVariables> | ReactiveFunction<GetProjectQueryVariables>, options: VueApolloComposable.UseQueryOptions<GetProjectQuery, GetProjectQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<GetProjectQuery, GetProjectQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<GetProjectQuery, GetProjectQueryVariables>> = {}) {
            return VueApolloComposable.useQuery<GetProjectQuery, GetProjectQueryVariables>(GetProjectDocument, variables, options);
          }
export type GetProjectQueryCompositionFunctionResult = VueApolloComposable.UseQueryReturn<GetProjectQuery, GetProjectQueryVariables>;
export const GetProjectBoardsDocument = gql`
    query getProjectBoards($projectId: ID!) {
  node(id: $projectId) {
    ... on Project {
      id
      boards {
        id
        createdAt
        updatedAt
        name
      }
    }
  }
}
    `;

/**
 * __useGetProjectBoardsQuery__
 *
 * To run a query within a Vue component, call `useGetProjectBoardsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetProjectBoardsQuery` returns an object from Apollo Client that contains result, loading and error properties
 * you can use to render your UI.
 *
 * @param options that will be passed into the query, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/query.html#options;
 *
 * @example
 * const { result, loading, error } = useGetProjectBoardsQuery(
 *   {
 *      projectId: // value for 'projectId'
 *   }
 * );
 */
export function useGetProjectBoardsQuery(variables: GetProjectBoardsQueryVariables | VueCompositionApi.Ref<GetProjectBoardsQueryVariables> | ReactiveFunction<GetProjectBoardsQueryVariables>, options: VueApolloComposable.UseQueryOptions<GetProjectBoardsQuery, GetProjectBoardsQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<GetProjectBoardsQuery, GetProjectBoardsQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<GetProjectBoardsQuery, GetProjectBoardsQueryVariables>> = {}) {
            return VueApolloComposable.useQuery<GetProjectBoardsQuery, GetProjectBoardsQueryVariables>(GetProjectBoardsDocument, variables, options);
          }
export type GetProjectBoardsQueryCompositionFunctionResult = VueApolloComposable.UseQueryReturn<GetProjectBoardsQuery, GetProjectBoardsQueryVariables>;
export const GetProjectIssuesDocument = gql`
    query getProjectIssues($projectId: ID!) {
  node(id: $projectId) {
    ... on Project {
      id
      issues {
        id
        createdAt
        updatedAt
        summary
        description
        number
      }
    }
  }
}
    `;

/**
 * __useGetProjectIssuesQuery__
 *
 * To run a query within a Vue component, call `useGetProjectIssuesQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetProjectIssuesQuery` returns an object from Apollo Client that contains result, loading and error properties
 * you can use to render your UI.
 *
 * @param options that will be passed into the query, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/query.html#options;
 *
 * @example
 * const { result, loading, error } = useGetProjectIssuesQuery(
 *   {
 *      projectId: // value for 'projectId'
 *   }
 * );
 */
export function useGetProjectIssuesQuery(variables: GetProjectIssuesQueryVariables | VueCompositionApi.Ref<GetProjectIssuesQueryVariables> | ReactiveFunction<GetProjectIssuesQueryVariables>, options: VueApolloComposable.UseQueryOptions<GetProjectIssuesQuery, GetProjectIssuesQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<GetProjectIssuesQuery, GetProjectIssuesQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<GetProjectIssuesQuery, GetProjectIssuesQueryVariables>> = {}) {
            return VueApolloComposable.useQuery<GetProjectIssuesQuery, GetProjectIssuesQueryVariables>(GetProjectIssuesDocument, variables, options);
          }
export type GetProjectIssuesQueryCompositionFunctionResult = VueApolloComposable.UseQueryReturn<GetProjectIssuesQuery, GetProjectIssuesQueryVariables>;
export const UserOrganizationsDocument = gql`
    query userOrganizations($userId: ID!) {
  node(id: $userId) {
    ... on User {
      memberships {
        id
        createdAt
        updatedAt
        userFrom {
          id
        }
        userTo {
          id
        }
        organization {
          id
          createdAt
          updatedAt
          name
          photoUrl
        }
      }
    }
  }
}
    `;

/**
 * __useUserOrganizationsQuery__
 *
 * To run a query within a Vue component, call `useUserOrganizationsQuery` and pass it any options that fit your needs.
 * When your component renders, `useUserOrganizationsQuery` returns an object from Apollo Client that contains result, loading and error properties
 * you can use to render your UI.
 *
 * @param options that will be passed into the query, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/query.html#options;
 *
 * @example
 * const { result, loading, error } = useUserOrganizationsQuery(
 *   {
 *      userId: // value for 'userId'
 *   }
 * );
 */
export function useUserOrganizationsQuery(variables: UserOrganizationsQueryVariables | VueCompositionApi.Ref<UserOrganizationsQueryVariables> | ReactiveFunction<UserOrganizationsQueryVariables>, options: VueApolloComposable.UseQueryOptions<UserOrganizationsQuery, UserOrganizationsQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<UserOrganizationsQuery, UserOrganizationsQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<UserOrganizationsQuery, UserOrganizationsQueryVariables>> = {}) {
            return VueApolloComposable.useQuery<UserOrganizationsQuery, UserOrganizationsQueryVariables>(UserOrganizationsDocument, variables, options);
          }
export type UserOrganizationsQueryCompositionFunctionResult = VueApolloComposable.UseQueryReturn<UserOrganizationsQuery, UserOrganizationsQueryVariables>;
export const UserProjectsDocument = gql`
    query userProjects($userId: ID!) {
  node(id: $userId) {
    ... on User {
      projects {
        id
        name
      }
    }
  }
}
    `;

/**
 * __useUserProjectsQuery__
 *
 * To run a query within a Vue component, call `useUserProjectsQuery` and pass it any options that fit your needs.
 * When your component renders, `useUserProjectsQuery` returns an object from Apollo Client that contains result, loading and error properties
 * you can use to render your UI.
 *
 * @param options that will be passed into the query, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/query.html#options;
 *
 * @example
 * const { result, loading, error } = useUserProjectsQuery(
 *   {
 *      userId: // value for 'userId'
 *   }
 * );
 */
export function useUserProjectsQuery(variables: UserProjectsQueryVariables | VueCompositionApi.Ref<UserProjectsQueryVariables> | ReactiveFunction<UserProjectsQueryVariables>, options: VueApolloComposable.UseQueryOptions<UserProjectsQuery, UserProjectsQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<UserProjectsQuery, UserProjectsQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<UserProjectsQuery, UserProjectsQueryVariables>> = {}) {
            return VueApolloComposable.useQuery<UserProjectsQuery, UserProjectsQueryVariables>(UserProjectsDocument, variables, options);
          }
export type UserProjectsQueryCompositionFunctionResult = VueApolloComposable.UseQueryReturn<UserProjectsQuery, UserProjectsQueryVariables>;